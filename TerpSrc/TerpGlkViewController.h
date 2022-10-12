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

@property (nonatomic, strong) IBOutlet NotesViewController *notesvc;
@property (nonatomic, strong) IBOutlet SettingsViewController *settingsvc;

+ (TerpGlkViewController *) singleton;

- (TerpGlkDelegate *) terpDelegate;
- (IBAction) showPreferences;
- (void) handleSwipeLeft:(UIGestureRecognizer *)recognizer;
- (void) handleSwipeRight:(UIGestureRecognizer *)recognizer;

@end
