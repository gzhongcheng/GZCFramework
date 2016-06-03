//
//  SearchButtonsView.h
//  MeiJiaXiu
//
//  Created by GuoZhongCheng on 16/2/19.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchButtonsView;
@protocol SearchButtonsViewDelegate <NSObject>

-(void)searchButtonsView:(SearchButtonsView*)searchbuttonsview
           titleDidTaped:(NSString*)title
                 atIndex:(NSInteger)index;

@end

typedef void(^SearchBtnTaped)(NSString *title,NSInteger index);

@interface SearchButtonsView : UIView

@property(nonatomic,weak) id<SearchButtonsViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame
                icon:(NSString*)iconName
               title:(NSString*)title
               items:(NSArray*)items;

-(void)setBlock:(SearchBtnTaped)taped;

@end
