/* TerpTabBarControllerDelegate.h: Interpreter-specific subclass of
 the IosGlk tab bar controller delegate
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "IosGlkTabBarControllerDelegate.h"

@class NotesViewController, SettingsViewController;

NS_ASSUME_NONNULL_BEGIN

@interface TerpTabBarControllerDelegate : IosGlkTabBarControllerDelegate

@property (nonatomic, assign) NotesViewController *notesvc;
@property (nonatomic, assign) SettingsViewController *settingsvc;

@end

NS_ASSUME_NONNULL_END
