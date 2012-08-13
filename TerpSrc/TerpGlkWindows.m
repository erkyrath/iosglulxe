/* TerpGlkWindows.m: Interpreter-specific window buffer subclasses, for the IosGlk library
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "TerpGlkWindows.h"
#import "StyledTextView.h"
#import "TerpGlkViewController.h"
#import "TerpGlkDelegate.h"

@implementation TerpGlkWinBufferView

- (id) initWithWindow:(GlkWindowState *)winref frame:(CGRect)box margin:(UIEdgeInsets)margin {
	self = [super initWithWindow:winref frame:box margin:margin];
	if (self) {
		TerpGlkViewController *glkviewc = [TerpGlkViewController singleton];
		int val = glkviewc.terpDelegate.colorscheme;
		self.textview.indicatorStyle = (val==2 ? UIScrollViewIndicatorStyleWhite : UIScrollViewIndicatorStyleDefault);
	}
	return self;
}

- (void) uncacheLayoutAndStyles {
	[super uncacheLayoutAndStyles];

	TerpGlkViewController *glkviewc = [TerpGlkViewController singleton];
	int val = glkviewc.terpDelegate.colorscheme;
	self.textview.indicatorStyle = (val==2 ? UIScrollViewIndicatorStyleWhite : UIScrollViewIndicatorStyleDefault);
}

@end
