//
//  MSPayResultViewController.m
//  MemberSystem
//
//  Created by GuoZhongCheng on 16/7/28.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "PayResultViewController.h"
#import "ProjectMacros.h"

// Controllers

// Model

// Views


//#define <#macro#> <#value#>


@interface PayResultViewController ()

//@property (nonatomic, strong) <#type#> *<#name#>

@end

@implementation PayResultViewController{
    UIImageView *resultImage;
    UILabel *resultPlaceHolder;
    UIButton *returnButton;
}

-(void)setupSubViews{
    self.titleString = @"影讯列表";
    self.showsBack = YES;
    [super setupSubViews];
    [self initialSubViews];
}


#pragma mark - Override

#pragma mark - Initial Methods

- (void)initialSubViews{
    resultImage = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-100)/2, 30, 100, 100)];
    resultImage.image = [UIImage imageNamed:@"pay_success"];
    [self.contentView addSubview:resultImage];
    
    resultPlaceHolder = [[UILabel alloc]initWithFrame:CGRectMake(0, resultImage.bottom +10, KScreenWidth, 30)];
    resultPlaceHolder.textAlignment = NSTextAlignmentCenter;
    resultPlaceHolder.font = SYSTEMFONT(16);
    resultPlaceHolder.text = @"充值成功";
    [self.contentView addSubview:resultPlaceHolder];
    
    resultPlaceHolder = [[UILabel alloc]initWithFrame:CGRectMake(30, resultPlaceHolder.bottom, KScreenWidth-60, 50)];
    resultPlaceHolder.textAlignment = NSTextAlignmentCenter;
    resultPlaceHolder.font = SYSTEMFONT(13);
    resultPlaceHolder.numberOfLines = 0;
    resultPlaceHolder.textColor = [UIColor grayColor];
    resultPlaceHolder.text = @"充值金额将在10分钟内到达账户。如未收到，请联系客服。";
    [self.contentView addSubview:resultPlaceHolder];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundImage:[UIImage imageWithRenderColor:mainColor renderSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageWithRenderColor:mainLightFontColor renderSize:CGSizeMake(1, 1)] forState:UIControlStateDisabled];
    [returnButton setTitle:@"返回会员中心" forState:UIControlStateNormal];
    [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    returnButton.layer.cornerRadius = 22;
    returnButton.clipsToBounds = YES;
    returnButton.frame = CGRectMake(10, resultPlaceHolder.bottom +20, KScreenWidth-20, 44);
    [returnButton addTarget:self action:@selector(backBtnTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:returnButton];
}


#pragma mark - Target Methods
- (void)popSelf {
    [self popToRootViewControllerAnimated:YES];
}
-(void)backBtnTaped:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Notification Methods


#pragma mark - KVO Methods


#pragma mark - UITableViewDelegate, UITableViewDataSource


#pragma mark - Privater Methods


#pragma mark - Setter Getter Methods




@end
