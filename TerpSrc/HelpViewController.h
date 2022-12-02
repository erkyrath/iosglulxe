/* HelpViewController.h: Interpreter help tab view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface HelpViewController : UIViewController <WKNavigationDelegate>

@property (nonatomic, strong) IBOutlet WKWebView *webview;

@end
