//
//  GZCAddTableViewCell.h
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@interface GZCAdModel : NSObject
@property (nonatomic,copy)NSString* src;    //跳转链接
@property (nonatomic,copy)NSString* url;    //图片地址
@end

typedef void(^AdTaped)(GZCAdModel *ad,NSInteger index);

@protocol GZCAdTableViewCellDelegate <NSObject>

-(void)AdTaped:(GZCAdModel*)model;

@end

@interface GZCAdTableViewCell : GZCLineTableViewCell

@property (nonatomic,weak) id<GZCAdTableViewCellDelegate> delegate;

@property (nonatomic,copy) AdTaped tapBlock;

-(void)setHeight:(float)height;

-(void)setAdModels:(NSArray<__kindof GZCAdModel*>*)adModels;
-(void)setAdUrls:(NSArray<__kindof NSString*>*)adModels;

-(void)setBlock:(AdTaped)block;


@end
