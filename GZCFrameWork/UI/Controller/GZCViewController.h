//
//  GZCBaseVC.h
//  GZCFramework
//
//  Created by GuoZhongCheng on 15/12/23.
//  Copyright © 2015年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZCFramework.h"

@interface GZCViewController : UIViewController

@property (nonatomic, assign) BOOL showBackBtn;
@property (nonatomic, assign) BOOL shareFriend;
@property (nonatomic,   copy) NSString *itemTitle;
@property (nonatomic,   copy) NSString *requestURL;
@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;

- (void)setNavBackgroundColor:(UIColor*)color;
- (void)setNavBackgroundColorString:(NSString*)colorstring;
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage
                               htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock;
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage
                                htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock;

- (void)pushViewControllerWithOutBackTitle:(UIViewController*)controller;

@end
