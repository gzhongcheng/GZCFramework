//
//  GZCAdBtnTableViewCell.h
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//
//  图片加文字的按钮行

#import "GZCLineTableViewCell.h"

@interface GZCAdBtnModel : NSObject
@property (nonatomic,copy)NSString* src;          //跳转链接
@property (nonatomic,copy)NSString* imageUrl;     //图片地址(网络)
@property (nonatomic,copy)NSString* imageName;    //图片名称(本地)
@property (nonatomic,copy)UIImage* bgImage;       //背景图片
@property (nonatomic,assign) CGSize imageSize;    //图片大小
@property (nonatomic,copy)NSString* title;        //标题
@property (nonatomic,copy)NSString* subTitle;     //子标题
@end

typedef void(^AdBtnTaped)(GZCAdBtnModel *ad);

@protocol GZCAdBtnTableViewCellDelegate <NSObject>

-(void)adBtnTaped:(GZCAdBtnModel*)model;

@end

@interface GZCAdBtnTableViewCell : GZCLineTableViewCell

@property (nonatomic,copy) AdBtnTaped tapBlock;
@property (nonatomic,weak) id<GZCAdBtnTableViewCellDelegate> delegate;
@property (nonatomic,strong) NSArray<__kindof GZCAdBtnModel *> *btnModels;
@property (nonatomic, strong) CALayer * line;      //分割线

//每行显示的按钮个数,默认4个
@property (nonatomic,assign) int numberOfButtonForLine;
@property (nonatomic, assign) int rowSpace;      //行间距

//按钮点击事件
-(void)setBlock:(AdBtnTaped)block;

@end
