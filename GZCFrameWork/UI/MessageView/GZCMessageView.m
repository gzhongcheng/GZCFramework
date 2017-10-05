//
//  GZCMessageView.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCMessageView.h"
#import "NSString+Size.h"
#import "ProjectMacros.h"
#import "UIView+AnimationProperty.h"

@implementation GZCMessageView

static GZCMessageView* messageView = nil;

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageView = [[GZCMessageView alloc] init];
    });
    return messageView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = messageBgColor;
        self.layer.cornerRadius = 5;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        self.clipsToBounds = YES;
        self.numberOfLines = 0;
    }
    return self;
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self sizeToFit];
    CGRect frame = self.frame;
    frame.size.width +=20;
    frame.size.height +=15;
    if (frame.size.width >= KScreenWidth-20) {
        frame.size.width = KScreenWidth-20;
        frame.size.height = [text heightWithFont:self.font constrainedToSize:CGSizeMake(KScreenWidth-20, MAXFLOAT)]+15;
    }
    self.frame = frame;
    self.center = CGPointMake(KScreenWidth/2, KScreenHeight/2);
}

+(void)showMessage:(NSString *)message inView:(UIView *)view displayTime:(float)display{
    GZCMessageView *mv = [GZCMessageView new];
    kDISPATCH_MAIN_BLOCK(^{
        mv.text = message;
        [view addSubview:mv];
        mv.center = CGPointMake(view.width/2, view.height/2);
        mv.scale = 1.5f;
        mv.alpha = 0.f;
        [UIView animateWithDuration:.25f animations:^{
            mv.scale = 1.f;
            mv.alpha = 1.f;
        }];
        [UIView animateWithDuration:.25f delay:display options:UIViewAnimationOptionCurveEaseInOut animations:^{
            mv.alpha = 0.f;
            mv.scale = 1.5f;
        } completion:^(BOOL finished) {
            [mv removeFromSuperview];
        }];
    });
}

+ (void)showMessage:(NSString *)message{
    [self showMessage:message inView:[UIApplication sharedApplication].keyWindow displayTime:1.f];
}


@end
