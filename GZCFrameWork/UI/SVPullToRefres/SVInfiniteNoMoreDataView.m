//
//  SVInfiniteNoMoreDataView.m
//  tenric
//
//  Created by tenric on 15/12/24.
//  Copyright © 2015年 tenric. All rights reserved.
//

#import "SVInfiniteNoMoreDataView.h"

@implementation SVInfiniteNoMoreDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.text = @"没有数据了";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}



@end
