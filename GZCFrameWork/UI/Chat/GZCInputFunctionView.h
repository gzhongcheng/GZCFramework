//
//  GZCInputFunctionView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/25.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GZCInputFunctionView;

@protocol GZCInputFunctionViewDelegate <NSObject>

// text
- (void)GZCInputFunctionView:(GZCInputFunctionView *)funcView sendMessage:(NSString *)message;

// image
- (void)GZCInputFunctionView:(GZCInputFunctionView *)funcView sendPicture:(UIImage *)image;

// audio
- (void)GZCInputFunctionView:(GZCInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second;

@end

@interface GZCInputFunctionView : UIView <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *btnChooseOther;
@property (nonatomic, strong) UIButton *btnChooseEmjoy;
@property (nonatomic, strong) UIButton *btnChangeVoiceState;
@property (nonatomic, strong) UIButton *btnVoiceRecord;
@property (nonatomic, strong) UITextView *TextViewInput;

@property (nonatomic, assign) BOOL isAbleToSendTextMessage;

@property (nonatomic, assign) UIViewController *superVC;

@property (nonatomic, assign) id<GZCInputFunctionViewDelegate>delegate;


- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)hideEmjoy;

@end