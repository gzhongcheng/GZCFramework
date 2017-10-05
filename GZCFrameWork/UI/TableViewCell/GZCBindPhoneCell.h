//
//  GZCBindPhoneCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/27.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  手机绑定

#import "GZCLineTableViewCell.h"

@interface GZCBindPhoneCell : GZCLineTableViewCell

@property (nonatomic, strong) UILabel * placeHolderLabel;    //提示信息
@property (nonatomic, strong) UITextField * phoneInput;      //手机号输入框
@property (nonatomic, strong) UITextField * codeInput;       //验证码输入框
@property (nonatomic, strong) UIButton * sendButton;         //发送验证码按钮

+(instancetype)cellOnTableView:(UITableView *)tableview;

@end
