/* TerpGlkViewController.h: Interpreter-specific subclass of the IosGlk view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>

#import "IosGlkViewController.h"

@interface TerpGlkViewController : IosGlkViewController

- (IBAction) pageDisplayChanged;
- (IBAction) showPreferences;

@end
