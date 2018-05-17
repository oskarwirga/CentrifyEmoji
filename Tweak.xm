#import <UIKit/UIKit.h>
@interface UIKeyboardDockItemButton : NSObject
// This is an actual method inside of it
-(id)setFrame:(CGRect)frame;
//@property (nonatomic, assign, readwrite) BOOL hidden;
@end

@interface UIKeyboardDockItem : NSObject
// This is an actual method inside of it
@property (nonatomic, assign, readwrite) UIKeyboardDockItemButton *button;
@end

static UIKeyboardDockItem *emojiFrame;
static UIKeyboardDockItemButton *emojiButton;

static UIKeyboardDockItem *leftDockItem;
static UIKeyboardDockItemButton *leftDockItemButton;

%hook UISystemKeyboardDockController

-(void)loadView {
    %orig;
    emojiFrame = MSHookIvar<UIKeyboardDockItem *>(self, "_globeDockItem");
    emojiButton = emojiFrame.button;
}

%end

%hook UIKeyboardDockView

-(void)loadView {
    %orig;
    leftDockItem = MSHookIvar<UIKeyboardDockItem *>(self, "_leftDockItem");
    leftDockItemButton = leftDockItem.button;
}

%end

%hook UIKeyboardDockItemButton

-(id)setFrame:(CGRect)frame {
    if(self == emojiButton) {
        CGRect newFrame = frame;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        newFrame.origin.x = (screenRect.size.width / 2) - 38;
        return %orig(newFrame);
    } else if(self == leftDockItemButton) {
        CGRect newFrame = frame;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        newFrame.origin.x = (screenRect.size.width / 2) - 38;
        return %orig(newFrame);
    } else { 
        return %orig; 
    }
}

%end

/*
static SBUILegibilityLabel *dateLabel;

%hook SBSearchEtceteraDateViewController

-(void)loadView {
    %orig;
    dateLabel = MSHookIvar<SBUILegibilityLabel *>(self, "_dateLabel"); 
}
%end

%hook SBUILegibilityLabel 

-(id)setFrame:(CGRect)frame { 
    if(self == dateLabel) { 
        CGRect newFrame = frame; 
        newFrame.origin.x = frame.origin.x/2; 
        return %orig(newFrame); } 
    else { 
        return %orig; 
    }


} 
%end
*/
