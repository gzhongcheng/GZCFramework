//
//  GZCAlertView.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/13.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCAlertView.h"
#import "GZCPushNoticeView.h"
#import "GZCQiandaoNoticeView.h"
#import "GZCShareView.h"
#import "GZCAlertTitleView.h"
#import "UtilsMacros.h"
#import "UIColor+Utils.h"

@implementation GZCAlertView

+(void)showWXSheetWithTitle:(NSString *)title
                    buttons:(NSArray *)buttons
                      block:(void (^)(NSInteger index,NSString *title))doneBlock{
    float alpha = 0.63f;
    float btnheight = 55;
    LEEAlertConfig *config = [LEEAlert actionsheet];
    config.config
    .LeeAddAction(^(LEEAction *action) {
        
        action.type = LEEActionTypeCancel;
        
        action.title = @"取消";
        
        action.height = btnheight;
        
        action.titleColor = [UIColor blackColor];
        
        action.font = [UIFont systemFontOfSize:18.0f];
        
        action.backgroundColor = [UIColor colorWithWhite:1.f alpha:alpha - 0.25f];
    })
    .LeeActionSheetCancelActionSpaceColor([UIColor colorWithWhite:1.f alpha:0.2f]) // 设置取消按钮间隔的颜色
    .LeeActionSheetBottomMargin(0.0f) // 设置底部距离屏幕的边距为0
    .LeeCornerRadius(0.0f) // 设置圆角曲率为0
    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
        
        // 这是最大宽度为屏幕宽度 (横屏和竖屏)
        
        return CGRectGetWidth([[UIScreen mainScreen] bounds]);
    })
    .LeeHeaderColor([UIColor colorWithWhite:1.f alpha:alpha])
    .LeeActionStyleBlur(UIBlurEffectStyleLight);
    
    if (title) {
        config.config
        .LeeContent(title);
    }
    
    for (int i = 0; i < [buttons count]; i ++) {
        id dic = buttons[i];
    
        config.config.LeeAddAction(^(LEEAction *action) {
            
            action.type = LEEActionTypeDefault;
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                action.title = dic[@"title"];
                if (dic[@"title_color"]) {
                    action.titleColor = [UIColor hexFloatColor:dic[@"title_color"]];
                }
            }else if([dic isKindOfClass:[NSString class]]){
                action.title = dic;
            }
            
            action.font = [UIFont systemFontOfSize:18.0f];
            
            action.backgroundColor = [UIColor clearColor];
            
            action.height = btnheight;
            
            __weak LEEAction *wAction = action;
            
            action.clickBlock = ^{
                if (doneBlock) {
                    doneBlock(i,wAction.title);
                }
            };
        });
    }
    config.config
    .LeeAddQueue()
    .LeeShow();
}

+(void)showAlertViewWithConfig:(GZCAlertHandle *)config doneBlock:(void (^)(NSInteger index,NSString *title))targetBlock{
    GZCAlertTitleView *alertTitleView = [[GZCAlertTitleView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 30.f, 30)];
    alertTitleView.title = config.title;
    alertTitleView.message = config.message;
    
    LEEAlertConfig *alertConfig = [LEEAlert alert];
    alertConfig.config
    .LeeHeaderInsets(UIEdgeInsetsZero)
    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
        return KScreenWidth - 30.f;
    })
    .LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = alertTitleView;
        custom.positionType = LEECustomViewPositionTypeCenter;
    })
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0));
    if (config.done.exist) {
        alertConfig.config
        .LeeAddAction(^(LEEAction *action) {
            action.type = LEEActionTypeDefault;
            action.title = config.done.text;
            action.titleColor = config.done.textColor;
            action.font = config.done.font;
            action.backgroundColor = config.done.backgroundColor;
            action.highlightColor = [UIColor grayColor];
            action.clickBlock = ^{
                if (targetBlock) {
                    targetBlock(0,config.done.text);
                }
            };
        });
    }
    if (config.cancel.exist) {
        alertConfig.config
        .LeeAddAction(^(LEEAction *action) {
            action.type = LEEActionTypeCancel;
            action.title = config.cancel.text;
            action.titleColor = config.cancel.textColor;
            action.font = config.cancel.font;
            action.backgroundColor = config.cancel.backgroundColor;
            action.highlightColor = [UIColor grayColor];
            action.clickBlock = ^{
                if (targetBlock) {
                    targetBlock(1,config.cancel.text);
                }
            };
        });
    }
    alertConfig.config
    .LeeAddQueue()
    .LeeShow();
}

+(void)showActionSheetWithTitle:(NSString *)title
                        buttons:(NSArray *)buttons
                          block:(void (^)(NSInteger, NSString *))targetBlock{
    LEEAlertConfig *config = [LEEAlert actionsheet];
    config.config
    .LeeCancelAction(@"取消", nil);
    if (title) {
        config.config.LeeTitle(title);
    }
    for (int i = 0; i < [buttons count]; i ++) {
        id dic = buttons[i];
        config.config.LeeAddAction(^(LEEAction *action){
            if ([dic isKindOfClass:[NSDictionary class]]) {
                action.title = dic[@"title"];
                if (dic[@"title_color"]) {
                    action.titleColor = [UIColor hexFloatColor:dic[@"title_color"]];
                }
            }else if([dic isKindOfClass:[NSString class]]){
                action.title = dic;
            }
            action.clickBlock = ^{
                if (targetBlock) {
                    targetBlock(i,title);
                }
            };
        });
    }
    config.config.LeeAddQueue().LeeShow();
}

+(void)showShareSheetWithInfoArray:(NSArray *)infoArray
                     MaxLineNumber:(NSInteger)maxLineNumber
                    MaxSingleCount:(NSInteger)maxSingleCount
                             block:(void (^)(NSInteger, NSString *))shareBlock{
    // 初始化分享视图
    GZCShareView *shareView = [[GZCShareView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 40, 0) InfoArray:infoArray MaxLineNumber:maxLineNumber MaxSingleCount:maxSingleCount];
    shareView.ShareButtonTapedBlock = ^(NSInteger index,NSString *tag){
        // 关闭
        [LEEAlert closeWithCompletionBlock:^{
            if (shareBlock) {
                shareBlock(index,tag);
            }
        }];
    };
    [LEEAlert actionsheet].config
    .LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = shareView;
        custom.positionType = LEECustomViewPositionTypeCenter;
    })
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = @"取消";
        action.titleColor = [UIColor grayColor];
    })
    .LeeAddQueue()
    .LeeShow();
}

+(void)showShareAlertWithInfoArray:(NSArray *)infoArray
                     MaxLineNumber:(NSInteger)maxLineNumber
                    MaxSingleCount:(NSInteger)maxSingleCount
                             block:(void (^)(NSInteger, NSString *))shareBlock{
    // 初始化分享视图
    GZCShareView *shareView = [[GZCShareView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 40, 0) InfoArray:infoArray MaxLineNumber:maxLineNumber MaxSingleCount:maxSingleCount];
    shareView.ShareButtonTapedBlock = ^(NSInteger index,NSString *tag){
        // 关闭
        [LEEAlert closeWithCompletionBlock:^{
            if (shareBlock) {
                shareBlock(index,tag);
            }
        }];
    };
    
    [LEEAlert alert].config
    .LeeMaxWidth(KScreenWidth-30)
    .LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = shareView;
        custom.positionType = LEECustomViewPositionTypeCenter;
    })
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeCancel;
        action.title = @"取消";
        action.titleColor = [UIColor grayColor];
    })
    .LeeAddQueue()
    .LeeShow();
}

+(void)showShareAlert{
    NSArray *info = @[@{@"title" : @"微信" ,
                        @"image" : @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2110913837,1215539170&fm=26&gp=0.jpg" ,
//                        @"highlightedImage" : @"popup_share_weixing_night" ,
                        @"tag" : @"微信"
                        } ,
                      @{@"title" : @"微信朋友圈" ,
                        @"image" : @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=263985165,4097393051&fm=26&gp=0.jpg" ,
//                        @"highlightedImage" : @"popup_share_penyouquan_night" ,
                        @"tag" : @"微信朋友圈"} ,
                    ];
    [self showShareAlertWithInfoArray:info MaxLineNumber:2 MaxSingleCount:3 block:^(NSInteger index, NSString *tag) {
        NSLog(@"%@",tag);
    }];
}

+(void)showQiandaoSuccessWithPrize:(NSString *)prizeURL
                             sroce:(NSString *)sroce
                               day:(NSString *)day
                              desc:(NSString *)desc
                         doneTitle:(NSString *)doneTitle
                         doneBlock:(NoticeDoneBlock)doneBlock{
    GZCQiandaoNoticeView *view = [[GZCQiandaoNoticeView alloc] initWithFrame:CGRectMake(0, 0, 280, 0)];
    view.prizeURL = prizeURL;
    view.sroce = sroce;
    view.day = day;
    view.desc = desc;
    view.doneTitle = doneTitle;
    view.doneBlock = doneBlock;
    [LEEAlert alert].config
    .LeeCustomView(view)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderColor([UIColor clearColor])
    .LeeAddQueue()
    .LeeShow();
}

+(void)showQiandaoSuccess{
    [self showQiandaoSuccessWithPrize:@"jindou"
                                sroce:@"+1"
                                  day:@"已经成功签到1天"
                                 desc:@"金豆可用于参与活动"
                            doneTitle:@"朕知道了"
                            doneBlock:nil];
}

+(void)showNoticeWithImage:(NSString *)imageURL
                     title:(NSString *)title
                   content:(NSString *)content
                 doneTitle:(NSString *)doneTitle
                 doneBlock:(NoticeDoneBlock)doneBlock
                closeBlock:(NoticeCloseBlock)closeBlock{
    GZCPushNoticeView *view = [[GZCPushNoticeView alloc] initWithFrame:CGRectMake(0, 0, 280, 0)];
    view.title = title;
    view.content = content;
    view.imageURL = imageURL;
    view.doneTitle = doneTitle;
    view.doneBlock = ^{
        if (doneBlock) {
            doneBlock();
        }
    };
    view.closeBlock = ^{
        if (closeBlock) {
            closeBlock();
        }
    };
    [LEEAlert alert].config
    .LeeCustomView(view)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeAddQueue()
    .LeeShow();
}

+(void)showPushNotice{
    [self showNoticeWithImage:@"open_push_image"
                        title:@"第一时间获知重要信息"
                      content:@"到设置中开启推送"
                    doneTitle:@"去设置"
                    doneBlock:^{
                                [kApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                            }
                   closeBlock:^{
                       
                            }];
}

@end
