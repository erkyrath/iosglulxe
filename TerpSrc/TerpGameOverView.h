/* TerpGameOverView.h: "Game Over" pop-up dialog
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>
#import "GameOverView.h"

@interface TerpGameOverView : GameOverView

- (IBAction) handleRestartButton:(id)sender;
- (IBAction) handleRestoreButton:(id)sender;
- (IBAction) handleQuitButton:(id)sender;

@end
