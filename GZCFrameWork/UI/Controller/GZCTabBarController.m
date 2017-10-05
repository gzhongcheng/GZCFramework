//
//  GZCTabBarController.m
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/28.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCTabBarController.h"
#import "UIImage+RenderedImage.h"
#import "GZCConstant.h"
#import "UIColor+HexColor.h"
#import "UIImage+Blur.h"

@implementation GZCTabBarButton{
    UIImage *selectedImage,*normalImage;
    UIColor *selectedColor,*normalColor;
    NSString *selectedString,*normalString;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_titleLabel];
        
        normalImage = [UIImage imageWithRenderColor:[UIColor whiteColor] renderSize:CGSizeMake(1, 1)];
        normalColor = [UIColor grayColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ((selectedString!=nil&&![selectedString isEqualToString:@""])||(normalString!=nil&&![normalString isEqualToString:@""])) {
        _imageView.frame = CGRectMake(0, 0, 24, 24);
        _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), 12+6);
        _titleLabel.hidden = NO;
        _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame)+1, CGRectGetWidth(self.frame), 15);
    }else{
        _imageView.frame = CGRectMake(0, 0, 43, 43);
        _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _titleLabel.hidden = YES;
    }
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selectedImage!=nil&&selected) {
        _imageView.image = selectedImage;
    }else{
        _imageView.image = normalImage;
    }
    if (selectedString!=nil&&![selectedString isEqualToString:@""]&&selected) {
        _titleLabel.text = selectedString;
    }else{
        _titleLabel.text = normalString;
    }
    if (selectedColor!=nil&&selected) {
        _titleLabel.textColor = selectedColor;
    }else{
        _titleLabel.textColor = normalColor;
    }
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    switch (state) {
        case UIControlStateSelected:
            selectedString = title;
            break;
        default:
            normalString = title;
            self.titleLabel.text = normalString;
            break;
    }
}

-(void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state{
    switch (state) {
        case UIControlStateSelected:
            selectedColor = titleColor;
            if (self.selected) {
                self.titleLabel.textColor = selectedColor;
            }
            break;
        default:
            normalColor = titleColor;
            self.titleLabel.textColor = normalColor;
            break;
    }
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    switch (state) {
        case UIControlStateSelected:
            selectedImage = image;
            break;
        default:
            normalImage = image;
            self.imageView.image = normalImage;
            break;
    }
}

-(void)setBadgeText:(NSString *)badgeText{
    [self initBadge];
    _badgeView.hidden = NO;
    _badgeView.badgeAlignment = GZCBadgeViewAlignmentTopRight;
    _badgeView.badgeText = badgeText;
}

-(void)setBadgePoint{
    [self initBadge];
    _badgeView.hidden = NO;
    _badgeView.badgeAlignment = GZCBadgeViewAlignmentTopRightWithoutNumber;
}

-(void)hideBadge{
    [self initBadge];
    _badgeView.hidden = YES;
}

-(void)initBadge{
    if (_badgeView == nil) {
        _badgeView = [[GZCBadgeView alloc]initWithParentView:_imageView alignment:GZCBadgeViewAlignmentTopRight];
        _badgeView.badgeOverlayColor = [UIColor clearColor];
        _badgeView.badgeStrokeColor = [UIColor clearColor];
        _badgeView.badgeTextShadowColor = [UIColor clearColor];
    }
}

@end

@interface GZCTabBar()

@property (nonatomic,weak) GZCTabBarButton *selectedBtn;

@end

@implementation GZCTabBar{
    NSMutableArray *buttons;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self), 1)];
        _lineView.backgroundColor = mainLineColor;
        [self addSubview:_lineView];
        buttons = [NSMutableArray array];
    }
    return self;
}

-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    for (GZCTabBarButton *btn in buttons) {
        [btn setTitleColor:tintColor forState:UIControlStateSelected];
    }
}

-(void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    [self addButtonWithTitle:nil normalTitleColor:nil selectedTitleColor:nil Image:image selectedImage:selectedImage];
}

-(void)addButtonWithTitle:(NSString *)title Image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    [self addButtonWithTitle:title normalTitleColor:nil selectedTitleColor:nil Image:image selectedImage:selectedImage];
}

- (void)addButtonWithTitle:(NSString *)title normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor Image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    GZCTabBarButton *btn = [[GZCTabBarButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (title!=nil) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor!=nil) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor!=nil) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (image!=nil) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage!=nil) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    [self addSubview:btn];
    [buttons addObject:btn];
    //带参数的监听方法记得加"冒号"
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (buttons.count == 1) {
        [self clickBtn:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = buttons.count;
    for (int i = 0; i < count; i++) {
        //取得按钮
        GZCTabBarButton *btn = buttons[i];
        
        btn.tag = i; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
    }
    if (_translucent) {
        self.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageWithRenderColor:self.backgroundColor renderSize:CGSizeMake(2, 2)] applyExtraLightEffect]];
        self.alpha = 0.8;
    }else{
        self.alpha = 1.f;
    }
}

- (void)clickBtn:(GZCTabBarButton *)button {
    BOOL shouldSelected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        shouldSelected = [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
    if (shouldSelected) {
        self.selectedBtn.selected = NO;
        button.selected = YES;
        self.selectedBtn = button;
    }
}


@end

@interface GZCTabBarController ()<GZCTabBarDelegate,UINavigationControllerDelegate>

@end

@implementation GZCTabBarController

@synthesize myTabBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.tabBar.frame;
    self.tabBar.frame = CGRectMake(rect.origin.x, rect.origin.y, 0, 0);
//    [self.tabBar removeFromSuperview];
    
    myTabBar = [[GZCTabBar alloc] initWithFrame:rect]; //设置代理必须改掉前面的类型,不能用UIView
    myTabBar.delegate = self; //设置代理
    myTabBar.backgroundColor = self.tabBar.barTintColor;
    myTabBar.translucent = self.tabBar.translucent;
    [self.view addSubview:myTabBar];
    
    for (int i=0; i<self.viewControllers.count; i++) { //根据有多少个子视图控制器来进行添加按钮
        UIViewController *controller = self.viewControllers[i];
        if ([controller isKindOfClass:[UINavigationController class]]) {
            ((UINavigationController*)controller).delegate = self;
        }
        
        UIImage *image = controller.tabBarItem.image;
        UIImage *imageSel = controller.tabBarItem.selectedImage;
        NSString *string = controller.tabBarItem.title;
        UIColor *color = [UIColor grayColor];
        UIColor *selColor = self.tabBar.tintColor;//RGB(92, 207, 195);
        
        [myTabBar addButtonWithTitle:string normalTitleColor:color selectedTitleColor:selColor Image:image selectedImage:imageSel];
        
        controller.tabBarItem.image = nil;
        controller.tabBarItem.selectedImage = nil;
        controller.tabBarItem.title = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UINavigationController Delegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.hidesBottomBarWhenPushed) {
        [self hideTabbarWithAnimated:animated];
    }else{
        [self showTabbarWithAnimated:animated];
    }
}

-(void)hideTabbarWithAnimated:(BOOL)animated{
    float duration = 0;
    if (animated) {
        duration = .25f;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        myTabBar.frame = CGRectMake(-WIDTH(myTabBar), MinY(myTabBar),WIDTH(myTabBar), HEIGHT(myTabBar));
    } completion:^(BOOL finished) {
//        self.tabBar.hidden = YES;
    }];
}

-(void)showTabbarWithAnimated:(BOOL)animated{
    float duration = 0;
    if (animated) {
        duration = .25f;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        myTabBar.frame = CGRectMake(0, MinY(myTabBar),WIDTH(myTabBar), HEIGHT(myTabBar));
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - GZCTabBar Delegate
- (BOOL)tabBar:(GZCTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
    return YES;
}

@end
