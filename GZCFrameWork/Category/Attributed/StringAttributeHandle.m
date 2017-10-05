//
//  StringAttributeHandle.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "StringAttributeHandle.h"

@implementation StringAttributeHandle

@end

@implementation FontAttribute

- (NSString *)attributeName {
    return NSFontAttributeName;
}


-(id)attributeValue{
    if (self.font) {
        
        return self.font;
        
    } else {
        
        return [UIFont systemFontOfSize:12.f];
    }
}

@end

@implementation ColorAttribute

- (NSString *)attributeName {
    return NSForegroundColorAttributeName;
}

- (id)attributeValue {
    
    if (self.color) {
        
        return self.color;
        
    } else {
        
        return [UIColor blackColor];
    }
}


@end
