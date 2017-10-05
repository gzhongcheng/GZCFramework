//
//  GZCAlertHandle.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCAlertHandle.h"

@implementation GZCAlertItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = @"";
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor darkGrayColor];
        self.backgroundColor = [UIColor whiteColor];
        self.exist = YES;
    }
    return self;
}

@end

@implementation GZCAlertHandle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = [GZCAlertItem new];
        self.title.font = [UIFont boldSystemFontOfSize:16];
        self.title.textColor = [UIColor blackColor];
        
        self.message = [GZCAlertItem new];
        self.message.textColor = [UIColor grayColor];
        
        self.done = [GZCAlertItem new];
        self.done.font = [UIFont systemFontOfSize:15];
        
        self.cancel = [GZCAlertItem new];
        self.cancel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
