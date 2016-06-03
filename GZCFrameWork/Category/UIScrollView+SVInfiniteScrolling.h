//
// UIScrollView+SVInfiniteScrolling.h
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
//

#import <UIKit/UIKit.h>

@class SVInfiniteScrollingView;
@class SVInfiniteScrollingLoadingView;
@class SVInfiniteNoMoreDataView;

@interface UIScrollView (SVInfiniteScrolling)

- (void)addInfiniteScrollingWithActionHandler:(void (^)(void))actionHandler;
- (void)triggerInfiniteScrolling;

@property (nonatomic, strong, readonly) SVInfiniteScrollingView *infiniteScrollingView;
@property (nonatomic, assign) BOOL showsInfiniteScrolling;

@property (nonatomic, assign) BOOL showsNoMoreDataView;

@end

enum {
	SVInfiniteScrollingStateStopped = 0,
    SVInfiniteScrollingStateTriggered,
    SVInfiniteScrollingStateLoading,
    SVInfiniteScrollingStateAll = 10
};

typedef NSUInteger SVInfiniteScrollingState;

@interface SVInfiniteScrollingView : UIView

@property (nonatomic, readonly) SVInfiniteScrollingState state;
@property (nonatomic, readwrite) BOOL enabled;
@property (nonatomic, assign) BOOL hasMoreData;

@property (nonatomic, strong) SVInfiniteScrollingLoadingView *loadingView;
@property (nonatomic, strong) UIView *noMoreDataView;

- (void)startAnimating;
- (void)stopAnimating;

@end
