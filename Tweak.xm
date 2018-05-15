%hook UIKeyboardDockItemButton


-(void)layoutSubviews {
    %orig;
    CGRect *frame = MSHookIvar<CGRect *>(self, "_frame");
    frame->origin.x = 50;
}

%end
