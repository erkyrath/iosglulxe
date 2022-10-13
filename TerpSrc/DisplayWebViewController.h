/* DisplayWebViewController.h: HTML Display view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DisplayWebViewController : UIViewController <WKNavigationDelegate>

@property (nonatomic, strong) IBOutlet WKWebView *webview;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *doctitle;

- (id) initWithNibName:(NSString *)nibName filename:(NSString *)filename title:(NSString *)title bundle:(NSBundle *)nibBundle;

@end
