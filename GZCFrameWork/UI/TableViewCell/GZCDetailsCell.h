//
//  GZCDetailsCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"
#import "SETextView.h"

typedef NS_ENUM(NSInteger, GZCDetailModelType) {
    GZCDetailModelTypeImage,	//图片
    GZCDetailModelTypeText      //文字
};

//详情(单个cell)
@interface GZCDetailModel : GZCBaseModel

@property (nonatomic, assign) GZCDetailModelType type;      //1为文字，0为图片

//图片时
@property (nonatomic, assign) CGSize imageSize;      //大小
@property (nonatomic, copy) NSString * imageUrl;     //链接

//文字时
@property (nonatomic, copy) NSString * textStr;     //文字内容
@property (nonatomic, copy) UIColor * textColor;      //文字颜色

//
@property (nonatomic, copy) NSString * tapKey;     //点击跳转的关键字

@end

@interface GZCDetailsCell : GZCLineTableViewCell

@property (nonatomic,strong) SETextView  *textView;     //仅在model.type==1时显示
@property (nonatomic, strong) UIImageView * imageV;      //仅在model.type==0时显示

@property (nonatomic, strong) GZCDetailModel * model;

@end
