/* ShareFilesViewController.m: Files list overview display view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "ShareFilesViewController.h"
#import "IosGlkViewController.h"
#import "RelDateFormatter.h"
#import "GlkLibrary.h"
#import "GlkFileRef.h"
#import "GlkFileTypes.h"
#import "GlkUtilities.h"

static int usages[] = { fileusage_SavedGame, fileusage_Transcript, fileusage_Data, fileusage_InputRecord, -1 };

@implementation ShareFilesViewController

@synthesize tableView;
@synthesize sharedocic;
@synthesize filelists;
@synthesize dateformatter;

- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
	self = [super initWithNibName:nibName bundle:nibBundle];
	if (self) {
		self.filelists = [NSMutableArray arrayWithCapacity:8];
		self.dateformatter = [[[RelDateFormatter alloc] init] autorelease];
		[dateformatter setDateStyle:NSDateFormatterMediumStyle];
		[dateformatter setTimeStyle:NSDateFormatterShortStyle];
	}
	return self;
}

- (void) dealloc {
	self.filelists = nil;
	self.dateformatter = nil;
	self.tableView = nil;
	self.sharedocic = nil;
	[super dealloc];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	
	self.navigationItem.title = NSLocalizedStringFromTable(@"title.sharefiles", @"TerpLocalize", nil);
	
	UIBarButtonItem *sendbutton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(buttonSend:)] autorelease];
	self.navigationItem.rightBarButtonItem = sendbutton;
	self.navigationItem.rightBarButtonItem.enabled = NO;
	
	/* We use an old-fashioned way of locating the Documents directory. (The NSManager method for this is iOS 4.0 and later.) */
	
	NSArray *dirlist = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	if (!dirlist) {
		dirlist = [NSArray array];
	}
	NSString *basedir = [dirlist objectAtIndex:0];
	
	[filelists removeAllObjects];
	for (int ux = 0; usages[ux] >= 0; ux++) {
		glui32 usage = usages[ux];
		NSString *dirname = [GlkFileRef subDirOfBase:basedir forUsage:usage gameid:[GlkLibrary singleton].gameId];
		NSMutableArray *files = nil;
		NSArray *ls = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirname error:nil];
		if (ls) {
			for (NSString *filename in ls) {
				NSString *pathname = [dirname stringByAppendingPathComponent:filename];
				NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:pathname error:nil];
				if (!attrs)
					continue;
				if (![NSFileTypeRegular isEqualToString:[attrs fileType]])
					continue;
				
				/* We accept both dumbass-encoded strings (which were typed by the user) and "normal" strings (which were created by fileref_by_name). */
				NSString *label = StringFromDumbEncoding(filename);
				if (!label)
					label = filename;
				
				GlkFileThumb *thumb = [[[GlkFileThumb alloc] init] autorelease];
				thumb.filename = filename;
				thumb.pathname = pathname;
				thumb.usage = usage;
				thumb.modtime = [attrs fileModificationDate];
				thumb.label = label;
				
				if (!files) {
					files = [NSMutableArray arrayWithCapacity:16];
					[filelists addObject:files];
				}
				[files addObject:thumb];
			}
		}
	}
	
	for (NSMutableArray *files in filelists) {
		[files sortUsingSelector:@selector(compareModTime:)];
	}
	
	if (filelists.count == 0)
		[self addBlankThumb];
}

- (void) addBlankThumb {
	GlkFileThumb *thumb = [[[GlkFileThumb alloc] init] autorelease];
	thumb.isfake = YES;
	thumb.modtime = [NSDate date];
	thumb.label = NSLocalizedStringFromTable(@"label.no-transcripts", @"TerpLocalize", nil);
	[filelists insertObject:[NSMutableArray arrayWithObject:thumb] atIndex:0];
}

- (void) buttonSend:(id)sender
{
	NSIndexPath *indexpath = [tableView indexPathForSelectedRow];
	if (!indexpath)
		return;
	
	GlkFileThumb *thumb = nil;
	
	int sect = indexpath.section;
	if (sect >= 0 && sect < filelists.count) {
		NSMutableArray *files = [filelists objectAtIndex:sect];
		int row = indexpath.row;
		if (row >= 0 && row < files.count)
			thumb = [files objectAtIndex:row];
	}
	if (!thumb)
		return;
	
	NSString *temppath = [thumb exportTempFile];
	if (!temppath)
		return;
	
	NSURL *url = [NSURL fileURLWithPath:temppath];
	self.sharedocic = [UIDocumentInteractionController interactionControllerWithURL:url];
	//NSLog(@"### docic URL %@, UTI %@", url, sharedocic.UTI);
	sharedocic.delegate = self;
	
	BOOL res = [sharedocic presentOpenInMenuFromBarButtonItem:sender animated:YES];
	if (!res) {
		self.sharedocic = nil;
		[[NSFileManager defaultManager] removeItemAtPath:temppath error:nil];
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"title.noshareapps", @"TerpLocalize", nil) message:NSLocalizedStringFromTable(@"label.noshareapps", @"TerpLocalize", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"button.drat", @"TerpLocalize", nil) otherButtonTitles:nil] autorelease];
		[alert show];
	}
	
	// I'm going to be lazy and leave the file in the temporary directory. I don't see a nice time to delete it. (didEndSendingToApplication happens after DidDismissOpenInMenu.) Hopefully "temporary" means what I think it means.
}

// Documentation Interaction delegate methods (see UIDocumentInteractionControllerDelegate)

- (void) documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)docic
{
	self.sharedocic = nil;
}

// Table view data source methods (see UITableViewDataSource)

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return filelists.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section < 0 || section >= filelists.count)
		return 0;
	
	NSMutableArray *files = [filelists objectAtIndex:section];
	return files.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section < 0 || section >= filelists.count)
		return @"???";

	NSMutableArray *files = [filelists objectAtIndex:section];
	// The array should be nonempty.
	if (!files.count)
		return @"???";
	
	GlkFileThumb *thumb = [files objectAtIndex:0];
	return [GlkFileThumb labelForFileUsage:thumb.usage localize:@"placeholders"];
}

- (UITableViewCell *) tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"File";
	
	// This is boilerplate and I haven't touched it.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	GlkFileThumb *thumb = nil;
	
	int sect = indexPath.section;
	if (sect >= 0 && sect < filelists.count) {
		NSMutableArray *files = [filelists objectAtIndex:sect];
		int row = indexPath.row;
		if (row >= 0 && row < files.count)
			thumb = [files objectAtIndex:row];
	}
	
	/* Make the cell look right... */
	
	if (!thumb) {
		// shouldn't happen
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.textLabel.text = @"(null)";
		cell.textLabel.textColor = [UIColor blackColor];
		cell.detailTextLabel.text = @"?";
	}
	else if (thumb.isfake) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.text = thumb.label;
		cell.textLabel.textColor = [UIColor lightGrayColor];
		cell.detailTextLabel.text = @"";
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.textLabel.text = thumb.label;
		cell.textLabel.textColor = [UIColor blackColor];
		cell.detailTextLabel.text = [dateformatter stringFromDate:thumb.modtime];
	}
	
	return cell;
}

// Table view delegate (see UITableViewDelegate)

- (void) tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	GlkFileThumb *thumb = nil;

	int sect = indexPath.section;
	if (sect >= 0 && sect < filelists.count) {
		NSMutableArray *files = [filelists objectAtIndex:sect];
		int row = indexPath.row;
		if (row >= 0 && row < files.count)
			thumb = [files objectAtIndex:row];
	}
	
	if (!thumb || thumb.isfake) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
		return;
	}
		
	/* The user has selected a file. */
	self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
	return [[IosGlkViewController singleton] shouldAutorotateToInterfaceOrientation:orientation];
}

@end
