//
//  ProjectMacros.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

//  项目参数

#ifndef ProjectMacros_h
#define ProjectMacros_h

#import "UIColor+Utils.h"
#import "UtilsMacros.h"

//设置状态栏字体颜色为白色 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//   info.plist中添加
/**
 <key>UIViewControllerBasedStatusBarAppearance</key>
 <false/>
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 **/

#define kNoMapMode              @"kNoMapMode"

#define kSCREEN_IMAGE_TAPED  @"kSCREEN_IMAGE_TAPED"

#define webImageBaseUrl      @""
#define webImageBigUrl       @""
#define webHeadBaseUrl       @""
#define webPlaceHolderImage       [UIImage imageNamed:@""]


#define BG_COLOR                    [UIColor hexFloatColor:@"f0f0f0"]
#define TABBAR_TEXT_NOR_COLOR       mainBlackFontColor
#define TABBAR_TEXT_HLT_COLOR       [UIColor hexFloatColor:@"d81c03"]
#define NAVBAR_COLOR                [UIColor hexFloatColor:@"ffffff"]
#define NAVBAR_TITLE_COLOR          [UIColor hexFloatColor:@"222222"]

//一些项目常用的颜色常数
//主色调
#define mainColor      [UIColor hexFloatColor:@"d7ad59"]
//较醒目的颜色（通常为红色）
#define mainStrikingColor  [UIColor hexFloatColor:@"fa6159"]

#define mainSelectedColor RGB(208,38,11)
#define messageBgColor RGBA(30,30,30,0.8)
#define mainColorAlpha(a) [mainColor colorWithAlphaComponent:a]
#define secondaryColor RGB(253,143,164)
#define mainLightLineColor [UIColor hexFloatColor:@"efefef"]
#define mainLineColor      RGB(229,229,229)
#define mainBlackFontColor      [UIColor hexFloatColor:@"333333"]
#define mainFontColor      [UIColor hexFloatColor:@"555555"]
#define mainLightFontColor      [UIColor hexFloatColor:@"aaaaaa"]

#define mainFontName       @"FZZhunYuan-M02"
#define mainFontBload      @"FZCuYuan-M03"

#define mainPlaceHolderImage [UIImage imageNamed:@""]

//一些常用常量
#define kMargin 15
#define kSpace 5
#define kLabelHeight 20

#endif /* FontAndColorMacros_h */
