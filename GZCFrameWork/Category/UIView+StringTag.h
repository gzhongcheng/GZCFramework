//
//  UIView+StringTag.h
//  Shop
//
//  Created by GuoZhongCheng on 16/1/4.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (StringTag)

@property (nonatomic, strong) NSString *stringTag;

- (UIView *)viewWithStringTag:(NSString *)tag;

- (UIView *)findFirstResponder;

@end
