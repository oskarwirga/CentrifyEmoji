#import <UIKit/UIKit.h>
@interface UIKeyboardDockItemButton : NSObject
@end

@interface UIKeyboardDockItem : NSObject
@property (nonatomic, assign, readwrite) UIKeyboardDockItemButton *button;
@end

static UIKeyboardDockItem *emojiFrame;
static UIKeyboardDockItemButton *emojiButton;


%hook UISystemKeyboardDockController

-(void)loadView {
    %orig;
    emojiFrame = MSHookIvar<UIKeyboardDockItem *>(self, "_globeDockItem");
    emojiButton = emojiFrame.button;
}

%end

%hook UIKeyboardDockItemButton

-(id)setFrame:(CGRect)frame {
    if(self == emojiButton) {
        CGRect newFrame = frame;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        newFrame.origin.x = (screenRect.size.width / 2) - 38;
        return %orig(newFrame);
    } else { 
        return %orig; 
    }
}

%end
