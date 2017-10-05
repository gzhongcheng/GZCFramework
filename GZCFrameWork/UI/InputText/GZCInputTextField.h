//
//  GZCInputTextField.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/11/30.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZCInputTextField;
@protocol GZCInputTextFieldDelegate <NSObject>

@optional
- (BOOL)textFieldShouldBeginEditing:(GZCInputTextField *)textField;        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(GZCInputTextField *)textField;           // became first responder
- (BOOL)textFieldShouldEndEditing:(GZCInputTextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(GZCInputTextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(GZCInputTextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0); // if implemented, called in place of textFieldDidEndEditing:

- (BOOL)textField:(GZCInputTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(GZCInputTextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(GZCInputTextField *)textField;              // called when 'return' key pressed. return NO to ignore.


@end

@interface GZCInputTextField : UIView

@property (nonatomic,copy) NSString * hint;  //提示信息

@property (nonatomic,copy) UIColor * textColor;  //文本颜色
@property (nonatomic,copy) UIColor * hintColor;  //提示信息颜色
@property (nonatomic,copy) UIColor * lineColor;  //下划线颜色（未获取焦点时）
@property (nonatomic,copy) UIColor * focusColor;  //获取焦点时的颜色（提示信息与下划线）
@property (nonatomic,copy) UIColor * errorColor;  //显示错误信息的颜色（提示信息与下划线）

@property (nonatomic,copy) UIFont * textFont;  //文字字体
@property (nonatomic,copy) UIFont * hintFont;  //提示文字字体

@property (nonatomic,assign) UIKeyboardType keyboardType;

@property (nonatomic,assign) UIEdgeInsets padding; //输入框距离四周的边距
    
@property (nonatomic,assign) BOOL showLine;  //是否显示下划线  默认YES
@property (nonatomic, getter = isSecureTextEntry) BOOL secureTextEntry;     //密码输入框

@property (nonatomic,weak) id   delegate;  //代理

-(void)showError:(NSString *)error;

-(void)showFocused;

-(void)showNormal;

-(void)setText:(NSString *)text;

-(NSString *)getText;

@end
