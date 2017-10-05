//
//  GZCAutoImagesView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/11.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  图片墙

#import <UIKit/UIKit.h>

@interface GZCAutoImage : NSObject

@property (nonatomic,assign) CGSize size;          //图片尺寸
@property (nonatomic,copy) NSString *imageUrl;     //图片地址
@property (nonatomic,copy) NSString *imageHref;    //跳转地址
@property (nonatomic, strong) UIImage * image;      //图片内容（从相册获取时）

@end

typedef NS_ENUM(NSInteger, GZCAutoImagesViewType) {
    GZCAutoImagesViewTypeNine     = 0 , // 九宫格
    GZCAutoImagesViewTypeVertical = 1   // 竖直排列
};

@class GZCAutoImagesView;
@protocol GZCAutoImagesViewDelegate <NSObject>

@optional

//图片高度变化时调用,newSize为self的最新size
-(void)autoImagesView:(GZCAutoImagesView*)autoImagesView
          sizeChanged:(CGSize)newSize;

//点击图片
-(void)autoImagesView:(GZCAutoImagesView*)autoImagesView
           imageTaped:(GZCAutoImage*)tapedImage
              atIndex:(NSInteger)index;

//点击添加图片按钮
-(void)autoImagesViewAddTaped:(GZCAutoImagesView *)autoImagesView;

//长按图片
-(void)autoImagesView:(GZCAutoImagesView*)autoImagesView
       imageLongTaped:(GZCAutoImage*)tapedImage
              atIndex:(NSInteger)index;

@end

@interface GZCAutoImagesView : UIView

@property (nonatomic,weak)   id<GZCAutoImagesViewDelegate>      delegate;

//九宫格（GZCAutoImagesViewTypeNine）的时候直接传链接即可
@property (nonatomic,strong) NSArray<__kindof NSString*>    *imageUrls;

//图片信息,与imageUrls不可共用，imageUrls和images都存在时，默认使用images,瀑布流（GZCAutoImagesViewTypeVertical）时推荐使用这个
@property (nonatomic, strong) NSArray<__kindof GZCAutoImage*> *images;

@property (nonatomic, strong) NSArray<__kindof UIImageView*> *imageViews;
@property (nonatomic, assign) int contentSpace;      //图片间距
@property (nonatomic, assign) GZCAutoImagesViewType type;      //样式 默认九宫格
@property (nonatomic, assign) BOOL enable;      //是否可编辑，仅在type为GZCAutoImagesViewTypeNine时有用，enable=YES且[imageUrls count]<9时，显示添加按钮，点击可以通过实现delegate的方法来添加图片

-(CGSize)getSize;

/**
 *  初始化
 *
 *  @param frame frame
 *  @param space 图片间距
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame space:(int)space;

/**
 *  初始化
 *
 *  @param frame frame
 *  @param space 间距
 *  @param type  显示方式
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame space:(int)space type:(GZCAutoImagesViewType)type;

-(void)addImage:(GZCAutoImage*)image;

-(void)addImages:(NSArray <__kindof GZCAutoImage*>*)images;

/**
 *  根据图片内容计算高度
 *
 *  @param images 图片内容数组
 *  @param space  图片间距
 *  @param type   显示风格
 *  @param autoImagesViewWidth   显示视图的宽度
 *
 *  @return 高度
 */
+(float)getHeightWithImages:( NSArray<__kindof GZCAutoImage*> *)images space:(float)space type:(GZCAutoImagesViewType)type autoImagesViewWidth:(float)width;


+(float)getHeightWithImages:( NSArray<__kindof GZCAutoImage*> *)images space:(float)space type:(GZCAutoImagesViewType)type autoImagesViewWidth:(float)width enable:(BOOL)enable;

@end
