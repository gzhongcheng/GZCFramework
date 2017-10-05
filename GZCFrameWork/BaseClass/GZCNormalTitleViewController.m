//
//  GZCNormalTitleViewController.m
//  GZCFramework
//
//  Created by ZhongCheng Guo on 2017/7/11.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCNormalTitleViewController.h"

@interface GZCNormalTitleViewController ()

/**
 返回箭头
 */
@property (nonatomic,strong) UIButton *backButton;

/**
 TitleLabel
 */
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation GZCNormalTitleViewController

-(void)viewDidLoad{
    self.showsTitle = YES;
    self.showsBack = NO;
    self.titleString = self.title;
    self.titleColor = [UIColor colorWithWhite:0.2f alpha:1.f];
    [super viewDidLoad];
}

- (void)setupSubViews {
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = SYSTEMFONT(17.f);
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.text          = self.titleString;
    headlinelabel.textColor     = _titleColor;
    [headlinelabel sizeToFit];
    headlinelabel.height = 44;
    _titleLabel = headlinelabel;
    headlinelabel.center = CGPointMake(self.titleView.middleX, self.titleView.height - headlinelabel.height/2.f);
    
    // Line.
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.height - 0.5f, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headlinelabel];
    
    // Back button.
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    backButton.center    = CGPointMake(20 , self.titleView.height - backButton.height/2.f);
    [backButton setImage:[UIImage imageNamed:@"backIcon"]             forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backIcon_highlighted"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
    _backButton = backButton;
    
    _backButton.hidden = !_showsBack;
    _titleLabel.hidden = !_showsTitle;
    
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    if (_titleLabel) {
        _titleLabel.textColor = titleColor;
    }
}

-(void)setShowsBack:(BOOL)showsBack{
    _showsBack = showsBack;
    if (_backButton) {
        _backButton.hidden = !showsBack;
    }
}

-(void)setShowsTitle:(BOOL)showsTitle{
    _showsTitle = showsTitle;
    if (_titleLabel) {
        _titleLabel.hidden = !showsTitle;
    }
}

-(void)setTitleString:(NSString *)titleString{
    [super setTitleString:titleString];
    if (_titleLabel) {
        _titleLabel.text = titleString;
        [_titleLabel sizeToFit];
        float offsetY = kApplication.statusBarHidden ? 0 : 10;
        _titleLabel.center = CGPointMake(self.titleView.middleX, self.titleView.middleY + offsetY);
    }
}

- (void)popSelf {
    [self popViewControllerAnimated:YES];
}
@end
