//
//  GZCConstant.h
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/2/23.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#ifndef GZCConstant_h
#define GZCConstant_h

#import "UIColor+HexColor.h"

#define LocationKey     @"3195059930ccc930ab7be50d1f937820"

#define kNoMapMode              @"kNoMapMode"

#define webImageBaseUrl      @""
#define webImageBigUrl       @""
#define webHeadBaseUrl       @""
#define webPlaceHolderImage       [UIImage imageNamed:@""]


#define BG_COLOR                    RGB(240,241,242)
#define TABBAR_TEXT_NOR_COLOR       RGB(153, 153, 153)
#define TABBAR_TEXT_HLT_COLOR       mainColor
#define NAVBAR_COLOR                RGB(253, 141, 170)
#define NAVBAR_TITLE_COLOR          RGB(255, 255, 255)
#define mainColor      RGB(252, 120, 155)
#define mainColorAlpha(a) RGBA(252, 120, 155,a)
#define secondaryColor RGB(253,143,164)
#define mainLightLineColor [UIColor hexFloatColor:@"ececec"]
#define mainLineColor      [UIColor hexFloatColor:@"e0e0e0"]
#define mainBlackFontColor      [UIColor hexFloatColor:@"333333"]
#define mainFontColor      [UIColor hexFloatColor:@"888888"]
#define mainLightFontColor      [UIColor hexFloatColor:@"aaaaaa"]

//改变颜色
#define CHANGE_COLOR_ALPHA(c,a)         [c colorWithAlphaComponent:a];

//获取坐标
#define MinX(v)     CGRectGetMinX(v.frame)
#define MinY(v)     CGRectGetMinY(v.frame)
#define MidX(v)     CGRectGetMidX(v.frame)
#define MidY(v)     CGRectGetMidY(v.frame)
#define MaxX(v)     CGRectGetMaxX(v.frame)
#define MaxY(v)     CGRectGetMaxY(v.frame)
#define WIDTH(v)    CGRectGetWidth(v.frame)
#define HEIGHT(v)   CGRectGetHeight(v.frame)

//改变坐标
#define RECT_CHANGE_x(v,x)          CGRectMake(x, MinY(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(MinX(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(MinX(v), MinY(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(MinX(v), MinY(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(MinX(v), MinY(v), w, h)

#define mainHeight     [[UIScreen mainScreen] bounds].size.height
#define mainWidth      [[UIScreen mainScreen] bounds].size.width
#define mainSizeScal    320.f/mainWidth             //缩放倍数
#define mainFontScal   (320.f/mainWidth -320/(int)mainWidth)*10/2   //字体增加号数，防止在4s下正常，6s时很小
#define mainFontName       @"FZZhunYuan-M02"
#define mainFontBload      @"FZCuYuan-M03"
#define navBarHeight   self.navigationController.navigationBar.frame.size.height

#define mainPlaceHolderImage [UIImage imageNamed:@""]

#ifdef DEBUG

#define GZCLog(...)  NSLog(__VA_ARGS__)
#define GZCPrint(...) printf(__VA_ARGS__)

#else

#define GZCLog(...)
#define GZCPrint(...)

#endif


#endif /* GZCConstant_h */
