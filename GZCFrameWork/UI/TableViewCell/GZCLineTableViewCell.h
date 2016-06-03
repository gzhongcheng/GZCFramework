//
//  GZCLineTableViewCell.h
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZCFramework.h"
//#import "UITableView+FDTemplateLayoutCell.h"

@interface GZCLineTableViewCell : UITableViewCell

@property (nonatomic,assign) int    spaceForTop;       //上方留白
@property (nonatomic,assign) int    spaceForBottom;    //下方留白
@property (nonatomic,assign) int    contentSpace;     //内容的上下留白，默认10
@property (nonatomic, assign) int   contentTopMargine;      //内容上边距
@property (nonatomic, assign) int   contentLeftMargine;     //内容左边距
@property (nonatomic, assign) int   contentRightMargine;    //内容右边距
@property (nonatomic, assign) int   contentBottomMargine;   //内容下边距

@property (nonatomic,assign) CGSize size;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size;

//画线，颜色位mainLineColor
-(CALayer*)drawLineToFrame:(CGRect)frame;
//画线
-(CALayer*)drawLineToFrame:(CGRect)frame color:(UIColor*)color;

//创建一个view 背景图片为mainLineColor
-(UIView*)getLine:(CGRect)frame;
//创建纯色背景的view
-(UIView*)getLine:(CGRect)frame color:(UIColor*)color;

-(CGSize)getContentSize;

+(float)getHightWithModel:(GZCBaseModel*)model;


@end
