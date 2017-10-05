//
//  GZCBindPhoneCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/27.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCBindPhoneCell.h"

@implementation GZCBindPhoneCell{
    UIImageView *phoneIconImageView;
    UIImageView *codeIconImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 130)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentSpace*1.5, 0, size.width-2*self.contentSpace, 25)];
        _placeHolderLabel.textColor = mainFontColor;
        _placeHolderLabel.text = @"绑定手机号码";
        _placeHolderLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_placeHolderLabel];
        
        UIView *phoneBg = [[UIView alloc]initWithFrame:CGRectMake(self.contentSpace, MaxY(_placeHolderLabel), size.width - 125 - 2*self.contentSpace, 40)];
        phoneBg.layer.borderColor = mainLineColor.CGColor;
        phoneBg.layer.borderWidth = 1;
        phoneBg.layer.cornerRadius = 3;
        phoneBg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:phoneBg];
        
        phoneIconImageView = [[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, HEIGHT(phoneBg), HEIGHT(phoneBg))];
        phoneIconImageView.contentMode = UIViewContentModeCenter;
        phoneIconImageView.image = [[UIImage imageNamed:@"bind_phone_icon"]reSizeToSize:CGSizeMake(20, 20)];
        [phoneBg addSubview:phoneIconImageView];
        
        _phoneInput = [[UITextField alloc]initWithFrame:CGRectMake(MaxX(phoneIconImageView), 0, WIDTH(phoneBg)-MaxX(phoneIconImageView), HEIGHT(phoneBg))];
        _phoneInput.placeholder = @"请输入手机号码";
        _phoneInput.font = [UIFont systemFontOfSize:13];
        _phoneInput.tintColor = mainColor;
        [phoneBg addSubview:_phoneInput];
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendButton setTitle:@"60秒后可重新发送" forState:UIControlStateDisabled];
        [_sendButton setBackgroundImage:[UIImage imageWithRenderColor:mainColor renderSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageWithRenderColor:mainLineColor renderSize:CGSizeMake(1, 1)] forState:UIControlStateDisabled];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:mainFontColor forState:UIControlStateDisabled];
        _sendButton.layer.cornerRadius = 5;
        _sendButton.clipsToBounds = YES;
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _sendButton.frame = CGRectMake(MaxX(phoneBg)+5, MinY(phoneBg), size.width - MaxX(phoneBg)-5-self.contentSpace, HEIGHT(phoneBg));
        [self.contentView addSubview:_sendButton];
        
        UIView *codeBg = [[UIView alloc]initWithFrame:CGRectMake(MinX(phoneBg), MaxY(phoneBg)+5, size.width - 2*MinX(phoneBg), HEIGHT(phoneBg))];
        codeBg.layer.borderColor = mainLineColor.CGColor;
        codeBg.layer.borderWidth = 1;
        codeBg.layer.cornerRadius = 3;
        codeBg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:codeBg];
        
        codeIconImageView = [[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, HEIGHT(codeBg), HEIGHT(codeBg))];
        codeIconImageView.contentMode = UIViewContentModeCenter;
        codeIconImageView.image = [[UIImage imageNamed:@"bind_key_icon"]reSizeToSize:CGSizeMake(20, 20)];
        [codeBg addSubview:codeIconImageView];
        
        _codeInput = [[UITextField alloc]initWithFrame:CGRectMake(MaxX(codeIconImageView), 0, WIDTH(codeBg)-MaxX(codeIconImageView), HEIGHT(codeBg))];
        _codeInput.placeholder = @"请输入短信中的验证码";
        _codeInput.font = [UIFont systemFontOfSize:13];
        _codeInput.tintColor = mainColor;
        [codeBg addSubview:_codeInput];
    }
    return self;
}

+(float)getHightWithModel:(GZCBaseModel *)model{
    return 130;
}

+(instancetype)cellOnTableView:(UITableView *)tableview{
    static NSString *bindCell = @"GZCBindPhoneCell";
    GZCBindPhoneCell *cell = (GZCBindPhoneCell*)[tableview  dequeueReusableCellWithIdentifier:bindCell];
    if(cell == nil)
    {
        cell = [[GZCBindPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bindCell];
    }
    return cell;
}

@end
