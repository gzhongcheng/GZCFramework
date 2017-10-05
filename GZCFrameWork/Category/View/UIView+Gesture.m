//
//  UIView+Gesture.m
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/8/18.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "UIView+Gesture.h"

@implementation UIView(Gesture)

-(void)addTapGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

-(void)addDoubleTapGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    tap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap];
}

-(void)addLongTapGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    longPressGesture.minimumPressDuration = 1;
    [self addGestureRecognizer:longPressGesture];
}

-(void)addLeftSwipeGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
     UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGesture];
}

-(void)addRightSwipeGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeGesture];
}

-(void)addUpSwipeGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeGesture];
}

-(void)addDownSwipeGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeGesture];
}

-(void)addPanGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:panGesture];
}

-(void)addPinchGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:pinchGesture];
}

-(void)addRotationGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:rotationGesture];
}

-(void)addScreenEdgePanGestureWithTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:target action:action];
    screenEdgePanGesture.edges = UIRectEdgeRight;
    [self addGestureRecognizer:screenEdgePanGesture];
}

@end
