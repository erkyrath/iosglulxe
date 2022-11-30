//
//  TerpGlkTabBarControllerDelegate.h
//  iosglulxe
//
//  Created by Administrator on 2022-11-30.
//

#import "IosGlkTabBarControllerDelegate.h"

@class NotesViewController, SettingsViewController;

NS_ASSUME_NONNULL_BEGIN

@interface TerpGlkTabBarControllerDelegate : IosGlkTabBarControllerDelegate

@property (nonatomic, assign) NotesViewController *notesvc;
@property (nonatomic, assign) SettingsViewController *settingsvc;

@end

NS_ASSUME_NONNULL_END
