//
//  GZCFullEffectTitleViewController.m
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/7/11.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCFullEffectTitleViewController.h"

@interface GZCFullEffectTitleViewController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;

@end

@implementation GZCFullEffectTitleViewController

-(void)makeViewsConfig:(NSMutableDictionary<NSString *,GZCVCBaseViewConfig *> *)viewsConfig{
    viewsConfig[contentViewId].frame = self.view.bounds;
}

- (void)setupSubViews {
    float offsetY = kApplication.statusBarHidden ? 0 : 10;
    
    // 添加模糊效果
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.effectView.frame                  = self.titleView.bounds;
    self.effectView.userInteractionEnabled = YES;
    [self.titleView addSubview:self.effectView];
    
    // 需要与作用的effectView的效果一致
    _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)self.effectView.effect]];
    _vibrancyEffectView.frame = self.effectView.bounds;
    [self.effectView.contentView addSubview:self.vibrancyEffectView];
    
    // Back button.
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center    = CGPointMake(20, self.titleView.middleY + offsetY);
    [backButton setImage:[UIImage imageNamed:@"backIcon"]             forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backIcon_highlighted"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
    
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = SYSTEMFONT(17.f);
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    headlinelabel.center        = CGPointMake(self.titleView.middleX, self.titleView.middleY + offsetY);
    [self.titleView addSubview:backButton];
    [self.titleView addSubview:headlinelabel];
}

- (void)popSelf {
    
    [self popViewControllerAnimated:YES];
}

@end
