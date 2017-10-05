//
//  GZCBaseViewController.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCBaseViewController.h"
#import "UtilsMacros.h"
#import "GZCMessageView.h"
#import "MBProgressHUD+Add.h"
#import "GZCAlertView.h"
#import "UIColor+Utils.h"
#import "SDImageCache.h"
#import "GZCWebViewController.h"
#import <sys/utsname.h>

typedef enum : NSUInteger {
    
    kEnterControllerType = 1000,
    kLeaveControllerType,
    kDeallocType,
    
} EDebugTag;

@interface GZCBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableDictionary <NSString *, GZCVCBaseViewConfig *> *viewsConfig;

@end

@implementation GZCBaseViewController

NSString * const titleViewId       = @"titleViewId";
NSString * const contentViewId     = @"contentViewId";
NSString * const backgroundViewId  = @"backgroundViewId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.navigationController!=nil) {
        self.navigationController.navigationBar.hidden = YES;
    }
    if ([self.navigationController.viewControllers[0] isEqual:self]) {
        self.hidesBottomBarWhenPushed = NO;
    }else{
        self.hidesBottomBarWhenPushed = YES;
    }
    
    [self initViewsConfigs];
    [self makeViewsConfig:self.viewsConfig];
    [self buildConfigViews];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**如果需要修改状态栏颜色，需在plist文件中添加以下代码：
     <key>UIViewControllerBasedStatusBarAppearance</key>
     <false/>
     */
    kApplication.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
#ifdef DEBUG
    [self debugWithString:@"[➡️] Did entered to" debugTag:kEnterControllerType];
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
#ifdef DEBUG
    [self debugWithString:@"[⛔️] Did left from" debugTag:kLeaveControllerType];
#endif
}

- (void)dealloc {
#ifdef DEBUG
    [self debugWithString:@"[❌] Did released the" debugTag:kDeallocType];
#endif
}

#pragma mark - init
- (void)initViewsConfigs {
    self.viewsConfig = [[NSMutableDictionary alloc] init];
    CGFloat width    = self.view.width;
    CGFloat height   = self.view.height;
    CGFloat offset   = 0;
    CGFloat bottomOffset = 0;
    if (Iphone_X_Device) {
        offset = 15;
        bottomOffset = 35;
    }
    
    // backgroundView config.
    {
        GZCVCBaseViewConfig *config   = [GZCVCBaseViewConfig new];
        config.exist                       = YES;
        config.frame                       = CGRectMake(0, 0, width, height);
        config.backgroundColor             = [UIColor whiteColor];
        self.viewsConfig[backgroundViewId] = config;
    }
    
    // contentView config.
    {
        GZCVCBaseViewConfig *config = [GZCVCBaseViewConfig new];
        config.exist                     = YES;
        config.frame                     = CGRectMake(0, offset + 64, width, height - 64 - offset - bottomOffset);
        config.backgroundColor           = [UIColor clearColor];
        self.viewsConfig[contentViewId]  = config;
    }
    
    // titleView config.
    {
        GZCVCBaseViewConfig *config = [GZCVCBaseViewConfig new];
        config.exist                     = YES;
        config.frame                     = CGRectMake(0, 0, width, 64.f + offset);
        config.backgroundColor           = [UIColor clearColor];
        self.viewsConfig[titleViewId]    = config;
    }

}

- (void)buildConfigViews {
    // backgroundView
    {
        GZCVCBaseViewConfig *config = self.viewsConfig[backgroundViewId];
        if (config && config.exist) {
            
            UIView *view         = [[UIView alloc] initWithFrame:config.frame];
            view.backgroundColor = config.backgroundColor;
            [self.view addSubview:view];
            self.backgroundView  = view;
        }
    }
    
    // contentView
    {
        GZCVCBaseViewConfig *config = self.viewsConfig[contentViewId];
        if (config && config.exist) {
            
            UIView *view         = [[UIView alloc] initWithFrame:config.frame];
            view.backgroundColor = config.backgroundColor;
            [self.view addSubview:view];
            self.contentView     = view;
        }
    }
    
    // titleView
    {
        GZCVCBaseViewConfig *config = self.viewsConfig[titleViewId];
        if (config && config.exist) {
            
            UIView *view         = [[UIView alloc] initWithFrame:config.frame];
            view.backgroundColor = config.backgroundColor;
            view.clipsToBounds = YES;
            [self.view addSubview:view];
            self.titleView       = view;
        }
    }
}

#pragma mark - push
-(void)pushViewControllerNamed:(NSString *)className withOutBackTitle:(BOOL)hideBackTitle{
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init];
    if (hideBackTitle) {
        [self pushViewControllerWithOutBackTitle:vc];
    }else{
        [self.navigationController pushViewController:vc animated:YES];
    }
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

-(void)presentViewControllerNamed:(NSString *)className{
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)tabbarSelectedIndex:(NSInteger)index{
    if (self.navigationController.tabBarController != nil) {
        [self.navigationController.tabBarController setSelectedIndex:index];
        return;
    }
    if (self.tabBarController != nil) {
        [self.tabBarController setSelectedIndex:index];
        return;
    }
}

#pragma mark - Navigation Maths
@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    _enableInteractivePopGestureRecognizer                            = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    return _enableInteractivePopGestureRecognizer;
}

- (void)useInteractivePopGestureRecognizer {
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)popViewControllerAnimated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:animated];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - private
-(void)endEditing:(BOOL)endediting{
    [self.view endEditing:endediting];
}

#pragma mark - 弹出提示信息
-(void)showMessage:(NSString *)message{
    [GZCMessageView showMessage:message];
}

-(void)showMessage:(NSString *)message displayTime:(float)display{
    [GZCMessageView showMessage:message inView:self.view displayTime:display];
}

-(void)showLodingMessage:(NSString *)message{
    [GCDQueue executeInMainQueue:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessag:message toView:self.view];
    }];
}

-(void)hideMessage{
    [GCDQueue executeInMainQueue:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)showError:(NSString *)message{
    [GCDQueue executeInMainQueue:^{
        [MBProgressHUD showError:message toView:self.view];
    }];
}

-(void)showSuccess:(NSString *)message{
    [GCDQueue executeInMainQueue:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showSuccess:message toView:self.view];
    }];
}

-(void)showAlertMessage:(NSString *)message{
    [self showAlertTitle:@"提示" message:message doneString:@"朕知道了" doneHandler:nil doneStyle:UIAlertActionStyleDefault cancelString:nil cancelHandler:nil];
}

-(void)showAlertTitle:(NSString *)title message:(NSString *)message{
    [self showAlertTitle:title message:message doneString:@"朕知道了" doneHandler:nil doneStyle:UIAlertActionStyleDefault cancelString:nil cancelHandler:nil];
}

-(void)showAlertMessage:(NSString *)message
             doneString:(NSString *)doneStr
            doneHandler:(void (^)())donehandler
           cancelString:(NSString *)cancelStr{
    [self showAlertMessage:message
                doneString:doneStr
               doneHandler:donehandler
                 doneStyle:UIAlertActionStyleDefault
              cancelString:cancelStr
             cancelHandler:nil];
}

-(void)showAlertMessage:(NSString *)message
             doneString:(NSString *)doneStr
            doneHandler:(void (^)())donehandler
           cancelString:(NSString *)cancelStr
          cancelHandler:(void (^)())cancelhandler{
    [self showAlertMessage:message
                doneString:doneStr
               doneHandler:donehandler
                 doneStyle:UIAlertActionStyleDefault
              cancelString:cancelStr
             cancelHandler:cancelhandler];
}

-(void)showAlertMessage:(NSString *)message
             doneString:(NSString *)doneStr
            doneHandler:(void (^)())donehandler
              doneStyle:(UIAlertActionStyle)doneStyle
           cancelString:(NSString *)cancelStr
          cancelHandler:(void (^)())cancelhandler{
    [self showAlertTitle:@"提示"
                 message:message
              doneString:doneStr
             doneHandler:donehandler
               doneStyle:doneStyle
            cancelString:cancelStr
           cancelHandler:cancelhandler];
}

-(void)showAlertTitle:(NSString *)title
              message:(NSString *)message
           doneString:(NSString *)doneStr
          doneHandler:(void (^)())donehandler
            doneStyle:(UIAlertActionStyle)doneStyle
         cancelString:(NSString *)cancelStr
        cancelHandler:(void (^)())cancelhandler{
    GZCAlertHandle *hander = [GZCAlertHandle new];
    hander.title.text = title;
    hander.title.textColor = [UIColor whiteColor];
    hander.title.backgroundColor = [UIColor hexFloatColor:@"F2412B"];
    hander.message.text = message;
    if (cancelStr ==nil || [cancelStr isEqualToString:@""]) {
        hander.cancel.exist = NO;
    }
    if (doneStr == nil || [doneStr isEqualToString:@""]) {
        hander.done.exist = NO;
    }
    hander.cancel.text = cancelStr;
    hander.cancel.textColor = [UIColor grayColor];
    hander.cancel.backgroundColor = [UIColor hexFloatColor:@"E6E6E6"];
    
    hander.done.text = doneStr;
    hander.done.textColor = [UIColor hexFloatColor:@"0072ff"];
    hander.done.backgroundColor = [UIColor hexFloatColor:@"EFEFEF"];
    if (doneStyle == UIAlertActionStyleDestructive) {
        hander.done.textColor = [UIColor hexFloatColor:@"F2412B"];
    }
    if (doneStyle == UIAlertActionStyleCancel) {
        hander.done.textColor = [UIColor grayColor];
    }
    [GZCAlertView showAlertViewWithConfig:hander doneBlock:^(NSInteger index, NSString *title) {
        if ([title isEqualToString:doneStr]) {
            if (donehandler) {
                donehandler();
            }
        }else if([title isEqualToString:cancelStr]){
            if (cancelhandler) {
                cancelhandler();
            }
        }
    }];
}


#pragma mark - 子类中重写.

- (void)makeViewsConfig:(NSMutableDictionary <NSString *, GZCVCBaseViewConfig *> *)viewsConfig {
    
}

- (void)setupSubViews {
    
}

#pragma mark - Debug message.

- (void)debugWithString:(NSString *)string debugTag:(EDebugTag)tag {
    
    NSDateFormatter *outputFormatter  = [[NSDateFormatter alloc] init] ;
    outputFormatter.dateFormat        = @"HH:mm:ss.SSS";
    
    NSString        *classString = [NSString stringWithFormat:@" %@ %@ [%@] ", [outputFormatter stringFromDate:[NSDate date]], string, [self class]];
    NSMutableString *flagString  = [NSMutableString string];
    
    for (int i = 0; i < classString.length; i++) {
        
        if (i == 0 || i == classString.length - 1) {
            
            [flagString appendString:@"+"];
            continue;
        }
        
        switch (tag) {
                
            case kEnterControllerType:
                [flagString appendString:@">"];
                break;
                
            case kLeaveControllerType:
                [flagString appendString:@"<"];
                break;
                
            case kDeallocType:
                [flagString appendString:@" "];
                break;
                
            default:
                break;
        }
    }
    
    NSString *showSting = [NSString stringWithFormat:@"\n%@\n%@\n%@\n", flagString, classString, flagString];
    GZCLog(@"%@", showSting);
}

@end
