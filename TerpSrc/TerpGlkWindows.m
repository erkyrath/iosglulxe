/* TerpGlkWindows.m: Interpreter-specific window buffer subclasses, for the IosGlk library
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import "TerpGlkWindows.h"
#import "TerpGlkViewController.h"
#import "TerpGlkDelegate.h"

@implementation TerpGlkWinBufferView

- (instancetype) initWithWindow:(GlkWindowState *)winref frame:(CGRect)box margin:(UIEdgeInsets)margin {
	self = [super initWithWindow:winref frame:box margin:margin];
	if (self) {
		TerpGlkViewController *glkviewc = [TerpGlkViewController singleton];
		BOOL isdark = glkviewc.hasDarkTheme;
		self.textview.indicatorStyle = (isdark ? UIScrollViewIndicatorStyleWhite : UIScrollViewIndicatorStyleDefault);
	}
	return self;
}

- (void) uncacheLayoutAndStyles {
	[super uncacheLayoutAndStyles];

	TerpGlkViewController *glkviewc = [TerpGlkViewController singleton];
	BOOL isdark = glkviewc.hasDarkTheme;
	self.textview.indicatorStyle = (isdark ? UIScrollViewIndicatorStyleWhite : UIScrollViewIndicatorStyleDefault);
}

@end
