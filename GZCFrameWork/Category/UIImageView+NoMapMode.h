//
//  UIImageView+NoMapMode.h
//  Shop
//
//  Created by GuoZhongCheng on 16/1/6.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (NoMapMode)

- (void)setWebImage:( NSString * _Nonnull )image;

- (void)setWebImage:(nullable NSString *)image placeholderImage:(nullable UIImage *)placeholder;

- (void)setWebImage:(nullable NSString*)baseUrl image:( NSString * _Nonnull )image;

- (void)setWebImage:(nullable NSString*)baseUrl image:( NSString * _Nonnull )image placeholderImage:(nullable UIImage * )placeholder;


- (void)setWebImage:( NSString * _Nonnull )image completed:(_Nullable SDWebImageCompletionBlock)completedBlock;

- (void)setWebImage:( NSString * _Nonnull )image  placeholderImage:(nullable UIImage * )placeholder completed:(_Nullable SDWebImageCompletionBlock)completedBlock;

- (void)setWebImage:(nullable NSString*)baseUrl image:( NSString * _Nonnull )image placeholderImage:(nullable UIImage * )placeholder completed:(_Nullable SDWebImageCompletionBlock)completedBlock;

@end
