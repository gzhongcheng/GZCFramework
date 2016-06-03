//
//  GZCBaseVC.m
//  GZCFramework
//
//  Created by GuoZhongCheng on 15/12/23.
//  Copyright © 2015年 GuoZhongCheng. All rights reserved.
//

#import "GZCViewController.h"
#import <objc/runtime.h>
#import "GZCFramework.h"

@interface GZCViewController ()

@end

@implementation GZCViewController
static char *btnClickAction;

@synthesize showBackBtn;

- (id)init {
    if (self = [super init]) {
        if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)])
        {
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        if([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)])
        {
            self.modalPresentationCapturesStatusBarAppearance = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBackgroundColor:NAVBAR_COLOR];
    self.navigationController.navigationBar.tintColor = NAVBAR_TITLE_COLOR;
    NSDictionary * dict=[NSDictionary dictionaryWithObjects:@[mainBlackFontColor,[UIFont systemFontOfSize:17]]
                                                    forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitle:(NSString *)title{
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = title;
    titleL.font = [UIFont systemFontOfSize:17];
    titleL.textColor = NAVBAR_TITLE_COLOR;
    [titleL sizeToFit];
    self.navigationItem.titleView = titleL;
}

-(void)setNavBackgroundColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * imge = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:imge forBarMetrics:UIBarMetricsDefault];
}

-(void)setNavBackgroundColorString:(NSString *)colorstring{
    [self setNavBackgroundColor:[UIColor hexFloatColor:colorstring]];
}

-(void)pushViewControllerWithOutBackTitle:(UIViewController *)controller{
    BOOL oldPush = self.hidesBottomBarWhenPushed;
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @" ";
    if (![self.parentViewController isKindOfClass:[UINavigationController class]]) {
        self.parentViewController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    }else{
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    }
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = oldPush;
}

#pragma mark -actionCustomLeftBtnWithNrlImage
- (void)actionCustomLeftBtnWithNrlImage:(NSString *)nrlImage
                               htlImage:(NSString *)hltImage
                                  title:(NSString *)title
                                 action:(void(^)())btnClickBlock {
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftBtn setBackgroundColor:[UIColor clearColor]];
    objc_setAssociatedObject(self.navLeftBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self actionCustomNavBtn:self.navLeftBtn nrlImage:nrlImage htlImage:hltImage title:title];
    UIView *backBtnView = [[UIView alloc] initWithFrame:self.navLeftBtn.bounds];
    [backBtnView addSubview:self.navLeftBtn];
    self.navLeftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
}

#pragma mark -actionCustomRightBtnWithNrlImage
- (void)actionCustomRightBtnWithNrlImage:(NSString *)nrlImage
                                htlImage:(NSString *)hltImage
                                   title:(NSString *)title
                                  action:(void(^)())btnClickBlock {
    self.navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navRightBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self actionCustomNavBtn:self.navRightBtn nrlImage:nrlImage htlImage:hltImage title:title];
    UIView *backBtnView = [[UIView alloc] initWithFrame:self.navRightBtn.bounds];
    [backBtnView addSubview:self.navRightBtn];
    self.navRightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
}

#pragma mark -actionCustomNavBtn
- (void)actionCustomNavBtn:(UIButton *)btn
                  nrlImage:(NSString *)nrlImage
                  htlImage:(NSString *)hltImage
                     title:(NSString *)title {
    [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    if (hltImage) {
        [btn setImage:[UIImage imageNamed:hltImage] forState:UIControlStateHighlighted];
    } else {
        [btn setImage:[UIImage imageNamed:nrlImage] forState:UIControlStateNormal];
    }
    if (title) {
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
        [btn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateHighlighted];
    }
    [btn sizeToFit];
    [btn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -actionBtnClick
- (void)actionBtnClick:(UIButton *)btn {
    void (^btnClickBlock) (void) = objc_getAssociatedObject(btn, &btnClickAction);
    btnClickBlock();
}

#pragma mark -getter or setter
- (void)setItemTitle:(NSString *)title {
    _itemTitle = title;
    [self.navigationItem setTitle:_itemTitle];
}

- (void)setShowBackBtn:(BOOL)showBack {
    __weak typeof(self) wSelf = self;
    // TODO TODO TODO - how to deal with the image resources?
    [self actionCustomLeftBtnWithNrlImage:@"btn_back" htlImage:nil title:nil action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
}

@end
