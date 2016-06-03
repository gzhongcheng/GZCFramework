//
//  SearchViewController.h
//  MeiJiaXiu
//
//  Created by GuoZhongCheng on 16/2/19.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCViewController.h"

@interface GZCSearchViewController : GZCViewController

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) NSArray * segmentTitles;;      //分段标题
@property (nonatomic, copy) NSString * searchPlaceHolder;     //搜索提示文字

-(void)showSearchResoult:(NSString *)searchText;

-(void)setSearchedHots:(NSArray*)hots historys:(NSArray*)historys;

@end
