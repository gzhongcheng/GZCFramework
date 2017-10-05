//
//  GZCBubbleView.h
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/3/16.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//  气泡控件

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, GZCBubbleType) {
//    GZCBubbleTypeText     = 0 , // 文字
//    GZCBubbleTypePicture  = 1   // 图片
//};

@interface GZCBubbleView : UIView

//边框宽度
@property (nonatomic,assign) int borderWidth;

//圆角角度
@property (nonatomic,assign) int cornerRadius;

//箭头大小（注：必须等于bubbleFrame.orgin.x-targetPoint.x或者bubbleFrame.orgin.y-targetPoint.y）
@property (nonatomic,assign) int pointerSize;

//阴影大笑
@property (nonatomic,assign) CGSize shadow;

//内容的位置（相对于self的）
@property (nonatomic,assign) CGRect bubbleFrame;

//箭头所指的位置（相对于self的）
@property (nonatomic,assign) CGPoint targetPoint;

//内容部分填充颜色
@property (nonatomic,copy) UIColor *conterColor;

//边框颜色
@property (nonatomic,copy) UIColor *borderColor;

//@property (nonatomic, assign) GZCBubbleType type;

-(instancetype)initWithFrame:(CGRect)frame
                 bubbleFrame:(CGRect)bubbleframe
                 targetPoint:(CGPoint)point
                 pointerSize:(int)size
                cornerRadius:(int)radius;

@end
