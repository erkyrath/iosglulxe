/* TerpGlkDelegate.h: Interpreter-specific delegate for the IosGlk library
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <Foundation/Foundation.h>
#import "IosGlkLibDelegate.h"

@interface TerpGlkDelegate : NSObject <IosGlkLibDelegate> {
	CGFloat maxwidth;
}

@property (nonatomic) CGFloat maxwidth;

@end
