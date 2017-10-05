//
//  GZCScrollImagesCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

typedef NS_ENUM(NSInteger, GZCScrollImageStyle) {
    GZCScrollImageStyleBottom,              //标题在图片的底部
    GZCScrollImageStyleCenter,              //标题在图片中间
    GZCScrollImageStyleCenterWithSubTitle,  //标题居中，并带子标题
    GZCScrollImageStyleTop                  //标题在图片顶部
};

@interface GZCScrImageModel : NSObject
@property (nonatomic,copy)NSString* src;          //跳转链接
@property (nonatomic,copy)NSString* imageUrl;     //图片地址(网络)
@property (nonatomic,copy)NSString* title;        //标题
@property (nonatomic,copy)NSString* subTitle;     //子标题
@end

@interface GZCTitleImage : UIView

@property (nonatomic,strong)UIImageView         *imageView;
@property (nonatomic,strong)UILabel             *titleLabel;
@property (nonatomic,strong)UILabel             *subTitleLabel;
@property (nonatomic,assign)GZCScrollImageStyle style;  //默认为GZCScrollImageStyleBottom
@property (nonatomic,strong)GZCScrImageModel    *model;

@end

@protocol GZCScrollImagesCellDelegate <NSObject>

-(void)GZCScrollImageTaped:(GZCScrImageModel*)model;

@end

typedef void(^GZCScrollImageTaped)(GZCScrImageModel *ad);

@interface GZCScrollImagesCell : GZCLineTableViewCell

@property (nonatomic,assign) CGSize                                 imageSize;//默认为CGSizeZero

@property (nonatomic,assign) GZCScrollImageStyle                    titleStyle;

@property (nonatomic,strong) UIColor                                *titleColor;
@property (nonatomic,strong) UIColor                                *titleBgColor;

@property (nonatomic,copy  ) GZCScrollImageTaped                    tapBlock;
@property (nonatomic,weak  ) id<GZCScrollImagesCellDelegate>        delegate;

@property (nonatomic,strong) NSArray<__kindof GZCScrImageModel *>   *btnModels;

@property (nonatomic,strong) UIScrollView                           *scrollView;


-(void)setBlock:(GZCScrollImageTaped)block;

@end
