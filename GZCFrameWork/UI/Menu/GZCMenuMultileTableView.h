//
//  GZCMenuTopPopView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZCMenuMultileTableView;
@protocol GZCMenuMultileTableViewDelegate <NSObject>

@optional
-(void)GZCMenuMultileTableViewBackgoundTaped:(GZCMenuMultileTableView *)multiletableview;

-(void)GZCMenuMultileTableView:(GZCMenuMultileTableView *)multiletableview
            leftTableCellTaped:(NSString *)title
                       atIndex:(NSIndexPath *)indexPath;


-(void)GZCMenuMultileTableView:(GZCMenuMultileTableView *)multiletableview
           rightTableCellTaped:(NSString *)title
                       atIndex:(NSIndexPath *)indexPath;

@end

@interface GZCMenuMultileTableView : UIView

@property (nonatomic, strong) UIColor * leftBgColor;      //左边背景颜色,默认[UIColor clearColor]
@property (nonatomic, strong) UIColor * rightBgColor;     //右边背景颜色,默认[UIColor clearColor]

@property (nonatomic, strong) UIColor * leftSelectColor;      //左边点中文字颜色,默认mainColor
@property (nonatomic, strong) UIColor * rightSelectColor;     //右边点中文字颜色，默认mainColor

@property (nonatomic, strong) UIColor * leftSelectBgColor;      //左边点中背景颜色，默认[UIColor whiteColor]
@property (nonatomic, strong) UIColor * rightSelectBgColor;     //右边点中背景颜色，默认[UIColor whiteColor]

@property (nonatomic, strong) UIColor * leftUnSelectColor;      //左边未点中文字颜色,默认mainFontColor
@property (nonatomic, strong) UIColor * rightUnSelectColor;     //右边未点中文字颜色,默认mainFontColor

@property (nonatomic, strong) UIColor * leftUnSelectBgColor;      //左边未点中背景颜色,默认BG_COLOR
@property (nonatomic, strong) UIColor * rightUnSelectBgColor;     //右边未点中背景颜色,默认[UIColor whiteColor]

@property (nonatomic, strong) UIColor * separatorColor;   //tablew 的分割线,默认mainLineColor

@property (nonatomic, assign) NSInteger menuColumn;      //列数,默认1,取值为1和2，其它值默认为2
@property (nonatomic, assign) CGFloat leftWidth;         //左边表格的宽度,默认mainWidth

@property (nonatomic, strong) NSArray<__kindof NSString*> * leftData;      //左边的数据
@property (nonatomic, strong) NSArray<__kindof NSString*> * rightData;     //右边的数据

@property (nonatomic,weak)   id<GZCMenuMultileTableViewDelegate> delegate;

-(void)setLeftSelectedAtIndexPath:(NSIndexPath*)indexPath;

-(void)setRightSelectedAtIndexPath:(NSIndexPath*)indexPath;

@end
