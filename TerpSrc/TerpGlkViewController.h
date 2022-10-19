/* TerpGlkViewController.h: Interpreter-specific subclass of the IosGlk view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>
#import "IosGlkViewController.h"

@class NotesViewController;
@class SettingsViewController;
@class TerpGlkDelegate;
@class GlkFileRefPrompt;

@interface TerpGlkViewController : IosGlkViewController <UITabBarControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NotesViewController *notesvc;
@property (nonatomic, strong) SettingsViewController *settingsvc;

+ (TerpGlkViewController *) singleton;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) TerpGlkDelegate *terpDelegate;
- (IBAction) showPreferences;
- (void) handleSwipeLeft:(UIGestureRecognizer *)recognizer;
- (void) handleSwipeRight:(UIGestureRecognizer *)recognizer;
@end
