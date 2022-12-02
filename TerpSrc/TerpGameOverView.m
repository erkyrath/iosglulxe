/* TerpGameOverView.m: "Game Over" pop-up dialog
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "TerpGameOverView.h"
#import "TerpGlkViewController.h"
#import "GlkAppWrapper.h"
#import "GlkLibrary.h"
#import "GlkFileRef.h"
#import "GlkFrameView.h"
#import "GlkFileTypes.h"

#import "iosstart.h"

@implementation TerpGameOverView


- (NSString *) nibForContent {
	if (iosglk_can_restart_cleanly())
	 	return @"GameOverView";
	else
		return @"FatalGameOverView";
}

- (IBAction) handleRestartButton:(id)sender {
	[self.superviewAsFrameView removePopMenuAnimated:YES];
	[[GlkAppWrapper singleton] acceptEventRestart];
}

- (IBAction) handleQuitButton:(id)sender {
	iosglk_shut_down_process();
}

@end
