//
//  UIImageView+NoMapMode.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/1/6.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NoMapMode)

/**
 设置网络图片

 @param image 图片地址（如是本地图片，则传入图片名称）
 */
- (void)setWebImage:( NSString * )image;


/**
 设置网络图片

 @param image 图片地址（如是本地图片，则传入图片名称）
 @param placeholder 加载中提示的图片
 */
- (void)setWebImage:( NSString *)image
   placeholderImage:( UIImage *)placeholder;

/**
 设置网络图片
 
 @param image 图片地址（如是本地图片，则传入图片名称）
 @param completedBlock 加载完成时的回调
 */
- (void)setWebImage:( NSString *  )image
          completed:( SDExternalCompletionBlock)completedBlock;


/**
 设置网络图片
 
 @param image 图片地址（如是本地图片，则传入图片名称）
 @param placeholder 加载中的提示图片
 @param completedBlock 加载完成时的回调
 */
- (void)setWebImage:( NSString *  )image
   placeholderImage:( UIImage * )placeholder
          completed:( SDExternalCompletionBlock)completedBlock;

/**
 设置网络图片

 @param baseUrl 固定头（某些特定情况，地址由统一的头部+尾部组成）
 @param image 尾部地址
 */
- (void)setWebImage:( NSString*)baseUrl
              image:( NSString *  )image;

/**
 设置网络图片

 @param baseUrl 固定头（某些特定情况，地址由统一的头部+尾部组成）
 @param image 尾部地址
 @param placeholder 加载中的提示图片
 */
- (void)setWebImage:( NSString*)baseUrl
              image:( NSString *  )image
   placeholderImage:( UIImage * )placeholder;

/**
 设置网络图片

 @param baseUrl 固定头（某些特定情况，地址由统一的头部+尾部组成）
 @param image 尾部地址
 @param placeholder 加载中的提示图片
 @param completedBlock 加载完成时的回调
 */
- (void)setWebImage:( NSString*)baseUrl
              image:( NSString *  )image
   placeholderImage:( UIImage * )placeholder
          completed:( SDExternalCompletionBlock)completedBlock;

@end
