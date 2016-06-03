//
//  GZCCityHotCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/28.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@class GZCCityHotCell;
@protocol GZCCityHotCellDelegate <NSObject>

-(void)hotCell:(GZCCityHotCell*)cell tapedCity:(NSString*)city;

@end

@interface GZCCityHotCell : GZCLineTableViewCell

@property (nonatomic, strong) NSArray <__kindof NSString*> * hotArray;      //热门城市

@property (nonatomic,weak)   id<GZCCityHotCellDelegate> delegate;

@end
