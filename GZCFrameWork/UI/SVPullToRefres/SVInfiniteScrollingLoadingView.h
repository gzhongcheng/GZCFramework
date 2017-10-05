//
//  SVInfiniteScrollingLoadingView.h
//  tenric
//
//  Created by tenric on 15/12/24.
//  Copyright © 2015年 tenric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVInfiniteScrollingLoadingView : UIView

@property (nonatomic, strong) CALayer *circlrLayer;
@property (nonatomic, strong) CALayer *lineLayer;

- (void)startLoading;

- (void)stopLoading;

@end
