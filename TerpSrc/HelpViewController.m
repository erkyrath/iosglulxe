/* HelpViewController.m: Interpreter help tab view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "HelpViewController.h"
#import "IosGlkViewController.h"
#import "TerpGlkViewController.h"
#import "IosGlkAppDelegate.h"

@implementation HelpViewController

@synthesize webview;

- (void) dealloc {
	if (webview) {
		webview.delegate = nil;
	}
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	NSBundle *bundle = [NSBundle mainBundle];
	// Do this the annoying iOS3-compatible way
	NSString *path = [bundle pathForResource:@"index" ofType:@"html" inDirectory:@"WebSite"];
	NSURL *url = [NSURL fileURLWithPath:path isDirectory:NO];
	NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	[webview loadHTMLString:html baseURL:url];
	webview.delegate = self;

	if (true) {
		TerpGlkViewController *mainviewc = [TerpGlkViewController singleton];
		UISwipeGestureRecognizer *recognizer;
		recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:mainviewc action:@selector(handleSwipeLeft:)];
		recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
		[webview addGestureRecognizer:recognizer];
		recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:mainviewc action:@selector(handleSwipeRight:)];
		recognizer.direction = UISwipeGestureRecognizerDirectionRight;
		[webview addGestureRecognizer:recognizer];
	}
}

/* Ensure that all external URLs are sent to Safari. (UIWebView delegate method.)
 */
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if ([request.URL isFileURL]) {
		/* Let file:... URLs load normally */
		NSString *anchor = request.URL.fragment;
		if (navigationType == UIWebViewNavigationTypeLinkClicked && anchor && anchor.length) {
			/* But handle internal anchor links with JS. UIWebView stopped handling this right in iOS11? */
			[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByName('%@')[0].scrollIntoView();", anchor]];
			return NO;
		}
		return YES;
	}
	
    [[UIApplication sharedApplication] openURL:request.URL options:@{} completionHandler:nil];
	return NO;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	IosGlkViewController *glkviewc = [IosGlkViewController singleton];
	return [glkviewc shouldAutorotateToInterfaceOrientation:orientation];
}

@end
