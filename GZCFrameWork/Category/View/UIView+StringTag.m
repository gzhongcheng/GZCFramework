//
//  UIView+StringTag.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/1/4.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIView+StringTag.h"
#import <objc/runtime.h>

static char viewStringTag;

@implementation UIView (StringTag)

- (void)setStringTag:(NSString *)stringTag{
    objc_setAssociatedObject(self, &viewStringTag, stringTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)stringTag{
    return objc_getAssociatedObject(self, &viewStringTag);
}

- (UIView *)viewWithStringTag:(NSString *)tag{
    UIView *targetView = nil;
    for (UIView *view in self.subviews) {
        if ([view.stringTag isEqualToString:tag]) {
            targetView = view;
            break;
        }else{
            targetView = [view viewWithStringTag:tag];
            if (targetView) {
                break;
            }
        }
    }
    return targetView;
}

- (UIView *)findFirstResponder{
    UIView *firstResponder = nil;
    if (self.isFirstResponder) {
        firstResponder = self;
    }else{
        for (UIView *view in self.subviews) {
            if (view.isFirstResponder) {
                firstResponder = view;
                break;
            }else{
                firstResponder = [view findFirstResponder];
                if (firstResponder) {
                    break;
                }
            }
        }
    }
    return firstResponder;
}

@end
