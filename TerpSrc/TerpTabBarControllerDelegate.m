/* TerpTabBarControllerDelegate.m: Interpreter-specific subclass of
 the IosGlk tab bar controller delegate
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "NotesViewController.h"
#import "SettingsViewController.h"

#import "TerpTabBarControllerDelegate.h"

@implementation TerpTabBarControllerDelegate


- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewc {

    [super tabBarController:tabBarController didSelectViewController:viewc];

    if (![viewc isKindOfClass:[UINavigationController class]])
        return;
    UINavigationController *navc = (UINavigationController *)viewc;
    NSArray *viewcstack = navc.viewControllers;
    if (!viewcstack || !viewcstack.count)
        return;
    UIViewController *rootviewc = viewcstack[0];
    //    NSLog(@"### tabBarController did select %@ (%@)", navc, rootviewc);

    if (rootviewc != self.notesvc) {
        /* If the notesvc was drilled into the transcripts view or subviews, pop out of there. */
        [self.notesvc.navigationController popToRootViewControllerAnimated:NO];
    }
    if (rootviewc != self.settingsvc) {
        /* If the settingsvc was drilled into a web subview, pop out of there. */
        [self.settingsvc.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (NotesViewController *)notesvc {
    if (_notesvc == nil) {
        for (UIViewController *vc in self.tabBarController.viewControllers) {
            if ([vc isKindOfClass:[NotesViewController class]])
                _notesvc = (NotesViewController *)vc;
        }
    }
    return _notesvc;
}

- (SettingsViewController *)settingsvc {
    if (_settingsvc == nil) {
        for (UIViewController *vc in self.tabBarController.viewControllers) {
            if ([vc isKindOfClass:[SettingsViewController class]])
                _settingsvc = (SettingsViewController *)vc;
        }
    }
    return _settingsvc;
}

@end