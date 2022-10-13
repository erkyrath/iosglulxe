/* TranscriptViewController.h: Transcript overview display view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>

@class GlkFileRefPrompt;
@class GlkFileThumb;

@interface TranscriptViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	UITableView *tableView;
	
	NSMutableArray *filelist; // array of GlkFileThumb
	NSDateFormatter *dateformatter;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *filelist;
@property (nonatomic, strong) NSDateFormatter *dateformatter;

- (instancetype) initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle;
- (void) addBlankThumb;

@end
