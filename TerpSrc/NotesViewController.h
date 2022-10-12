/* NotesViewController.h: Interpreter notes tab view controller
 for IosGlulxe, an IosGlk port of the Glulxe interpreter.
 Designed by Andrew Plotkin <erkyrath@eblong.com>
 http://eblong.com/zarf/glk/
 */

#import <UIKit/UIKit.h>

@class GradientView;
@class MButton;

@interface NotesViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate> {
	BOOL textchanged;
}

@property (nonatomic, strong) IBOutlet GradientView *gradview;
@property (nonatomic, strong) IBOutlet UITextView *textview;
@property (nonatomic, strong) IBOutlet UITableView *buttontable;
@property (nonatomic, strong) IBOutlet UITableViewCell *transcriptcell;

@property (nonatomic, strong) NSString *notespath;

- (IBAction) toggleKeyboard;
- (IBAction) handleTranscripts;
- (void) saveIfNeeded;

- (void) adjustToKeyboardBox;

@end
