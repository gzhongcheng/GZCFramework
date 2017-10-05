//
//  GZCShareView.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/14.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZCShareView : UIView

/**
 分享按钮点击回调
 */
@property (nonatomic , copy ) void (^ShareButtonTapedBlock)(NSInteger index,NSString *tag);

/**
 初始化分享试图

 @param frame frame
 @param infoArray 内容数组，格式如  @{
                                    @"title" : @"微信" ,
                                    @"image" : @"popup_share_weixing" ,
                                    @"highlightedImage" : @"popup_share_weixing_night" ,
                                    @"tag" : @"微信分享"
                                   }
                  需要注意的是，@"highlightedImage" 只有在 @"image"是本地图片时，才生效
 @param maxLineNumber 最大行数
 @param maxSingleCount 单行最大个数
 @return 分享视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                    InfoArray:(NSArray *)infoArray
                MaxLineNumber:(NSInteger)maxLineNumber
               MaxSingleCount:(NSInteger)maxSingleCount;

@end

@interface GZCShareButton : UIButton

/**
 上下间距
 */
@property (nonatomic , assign ) CGFloat space;

/**
 设置标题图标

 @param title 标题
 @param image 图标 网络地址／本地图片名称
 @param highlightedimage 高亮时图片地址
 */
- (void)configTitle:(NSString *)title Image:(NSString *)image highlightedImage:(NSString *)highlightedimage;

@end
