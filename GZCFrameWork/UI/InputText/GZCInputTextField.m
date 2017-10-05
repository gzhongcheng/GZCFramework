//
//  GZCInputTextField.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/11/30.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import "GZCInputTextField.h"
#import "UtilsMacros.h"
#import "ProjectMacros.h"
#import "UIImage+RenderedImage.h"
#import "SDAutoLayout.h"
#import "UIView+AnimationProperty.h"
#import "NSString+Size.h"

@interface GZCInputTextField()<UITextFieldDelegate>{
    BOOL isFocused;
    BOOL isErrorShow;
}

@property (nonatomic,strong) IBOutlet UITextField * textfield;  //输入框
@property (nonatomic,strong) IBOutlet UIImageView * hintImage;  //提示文字
@property (nonatomic,strong) IBOutlet UIImageView * focusImage;  //选中提示文字
@property (nonatomic,strong) IBOutlet UIImageView * errorImage;  //错误提示文字
@property (nonatomic,strong) IBOutlet UIView * line;  //下划线
@property (nonatomic,strong) IBOutlet UIButton * pwdBtn;  //是否显示密码文字


@end

@implementation GZCInputTextField{
    NSString *errorString;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildSubview];
        _showLine = YES;
        _hintFont = SYSTEMFONT(17);
        _hintColor = [UIColor grayColor];
        _errorColor = [UIColor redColor];
        [self setLineColor: mainBlackFontColor];
        [self setFocusColor:mainColor];
        isFocused = NO;
        isErrorShow = NO;
        [self setSecureTextEntry:NO];
        self.padding = UIEdgeInsetsMake(5, 20, 5, 20);
    }
    return self;
}

-(void)buildSubview{
    _hintImage = [[UIImageView alloc]init];//WithFrame:CGRectMake(0, self.height * 0.25, CGRectGetWidth(frame), CGRectGetHeight(frame) * 0.75)
    _hintImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_hintImage];
    
    _focusImage = [[UIImageView alloc]init];
    _focusImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_focusImage];
    _focusImage.alpha = 0;
    
    _errorImage = [[UIImageView alloc]init];
    _errorImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_errorImage];
    _errorImage.alpha = 0;
    
    _textfield = [[UITextField alloc]init];
    _textfield.borderStyle = UITextBorderStyleNone;
    _textfield.textColor = mainBlackFontColor;
    _textfield.font = SYSTEMFONT(17);
    _textfield.delegate = self;
    [self addSubview:_textfield];
    
    _pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pwdBtn setImage:[[UIImage imageNamed:@"eye_close"] reSizeToSize:CGSizeMake(20, 10)] forState:UIControlStateNormal];
    [_pwdBtn setImage:[[UIImage imageNamed:@"eye_open"] reSizeToSize:CGSizeMake(20, 20)] forState:UIControlStateSelected];
    [_pwdBtn addTarget:self action:@selector(changePwdState) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pwdBtn];
    
    _line = [[UIView alloc]init];
    [self addSubview:_line];
}

-(void)configLayout{
    [self zoomHint];
    
    float height = (self.height - _padding.bottom - _padding.top) * 0.7;
    
    self.textfield.sd_layout
    .leftSpaceToView(self, _padding.left)
    .rightSpaceToView(self, _padding.right)
    .bottomSpaceToView(self, _padding.bottom)
    .heightIs(height);
    
    self.pwdBtn.sd_layout
    .centerYEqualToView(self.textfield)
    .rightSpaceToView(self, _padding.right + 5)
    .widthIs(20)
    .heightIs(20);
    
    self.line.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .heightIs(0.5f);
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(BOOL)becomeFirstResponder{
    return [_textfield becomeFirstResponder];
}


#pragma mark - setter and getter
-(void)setPadding:(UIEdgeInsets)padding{
    _padding = padding;
    [self configLayout];
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    _textfield.secureTextEntry= secureTextEntry;
    _pwdBtn.hidden = !secureTextEntry;
}
    
-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    _textfield.keyboardType = keyboardType;
}

-(void)setHint:(NSString *)hint{
    _hint = hint;
    _hintImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_hintColor];
    _focusImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_focusColor==nil?_hintColor:_focusColor];
    [self zoomHint];
}

-(void)setHintColor:(UIColor *)hintColor{
    _hintColor = hintColor;
    _line.backgroundColor = _showLine?_hintColor:[UIColor clearColor];
    _hintImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_hintColor];
    _focusImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_focusColor==nil?_hintColor:_focusColor];
    [_pwdBtn setImage:[[[UIImage imageNamed:@"eye_close"] reSizeToSize:CGSizeMake(20, 11)] imageWithColor:_hintColor] forState:UIControlStateNormal];
    [_pwdBtn setImage:[[[UIImage imageNamed:@"eye_open"] reSizeToSize:CGSizeMake(20, 12)] imageWithColor:_hintColor] forState:UIControlStateSelected];
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _line.backgroundColor = _showLine?_lineColor:[UIColor clearColor];
}

-(void)setText:(NSString *)text{
    _textfield.text = text;
    if (text.length) {
        [self reducingHint];
    }else{
        [self zoomHint];
    }
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _textfield.textColor = textColor;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    _textfield.font = textFont;
}

-(void)setHintFont:(UIFont *)hintFont{
    _hintFont = hintFont;
    _hintImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_hintColor];
    _focusImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_focusColor==nil?_hintColor:_focusColor];
    [self zoomHint];
}

-(void)setFocusColor:(UIColor *)focusColor{
    _focusColor = focusColor;
    _textfield.tintColor = focusColor;
    _focusImage.image = [UIImage imageFromText:_hint withFont:_hintFont withColor:_focusColor];
}

-(void)setErrorColor:(UIColor *)errorColor{
    _errorColor = errorColor;
}

-(NSString *)getText{
    return _textfield.text;
}

#pragma mark - action

-(void)showError:(NSString *)error{
    errorString = error;
    _errorImage.image = [UIImage imageFromText:error withFont:_hintFont withColor:_errorColor];
    if (_textfield.text.length == 0) {
        [self zoomHint];
    }else{
        [self reducingHint];
    }
    _hintImage.alpha = 0.f;
    _focusImage.alpha = 0.f;
    _errorImage.alpha = 1.f;
    _line.backgroundColor = _lineColor?_errorColor:[UIColor clearColor];
    isErrorShow = YES;
}


-(void)changePwdState{
    _pwdBtn.selected = !_pwdBtn.selected;
    _textfield.secureTextEntry = !_pwdBtn.selected;
}

-(void)showFocused{
    [UIView animateWithDuration:.25f animations:^{
        _hintImage.alpha = 0.f;
        _focusImage.alpha = 1.f;
        _errorImage.alpha = 0.f;
        _line.height = 2;
        _line.backgroundColor = _showLine?_focusColor:[UIColor clearColor];
    }];
}

-(void)showNormal{
    [UIView animateWithDuration:.25f animations:^{
        _hintImage.alpha = 1.f;
        _focusImage.alpha = 0.f;
        _errorImage.alpha = 0.f;
        _line.height = 1;
        _line.backgroundColor = _showLine?_lineColor:[UIColor clearColor];
    }];
}

-(void)reducingHint{
    float oldHeight = (self.height - _padding.bottom - _padding.top) * 0.7;
    float oldTop = self.height - _padding.bottom - oldHeight;
    float height = oldHeight * 0.7;
    float width = [_hint sizeWithFont:_hintFont constrainedToSize:CGSizeMake(MAXFLOAT, _hintImage.height)].width * 0.7;
    self.hintImage.frame = CGRectMake(self.hintImage.left, oldTop - height, width , height);
    self.focusImage.frame = self.hintImage.frame;
    
    float errorWidth = [errorString sizeWithFont:_hintFont constrainedToSize:CGSizeMake(MAXFLOAT, oldHeight)].width * 0.7;
    self.errorImage.frame = self.hintImage.frame;
    self.errorImage.width = errorWidth;
}

-(void)zoomHint{
    float height = (self.height - _padding.bottom - _padding.top) * 0.7;
    float width = [_hint sizeWithFont:_hintFont constrainedToSize:CGSizeMake(MAXFLOAT, _hintImage.height)].width;
    self.hintImage.frame = CGRectMake(_padding.left, self.height - _padding.bottom - height, width , height);
    self.focusImage.frame = self.hintImage.frame;
    float errorWidth = [errorString sizeWithFont:_hintFont constrainedToSize:CGSizeMake(MAXFLOAT, height)].width;
    self.errorImage.frame = self.hintImage.frame;
    self.errorImage.width = errorWidth;
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    BOOL shouldBegin = YES;
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        shouldBegin = [self.delegate textFieldShouldBeginEditing:self];
    }
    if (shouldBegin) {
        if (textField.text.length == 0) {
            [UIView animateWithDuration:.25f animations:^{
                [self reducingHint];
                _hintImage.alpha = 0.f;
                _focusImage.alpha = !isErrorShow;
                _errorImage.alpha = isErrorShow;
                _line.sd_layout.heightIs(2);
                _line.backgroundColor = _showLine?(isErrorShow?_errorColor:_focusColor):[UIColor clearColor];
            }];
        }else{
            [UIView animateWithDuration:.25f animations:^{
                _hintImage.alpha = 0.f;
                _focusImage.alpha = !isErrorShow;
                _errorImage.alpha = isErrorShow;
                _line.sd_layout.heightIs(2);
                _line.backgroundColor = _showLine?(isErrorShow?_errorColor:_focusColor):[UIColor clearColor];
            }];
        }
        
    }
    return shouldBegin;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    isFocused = YES;
    isErrorShow = NO;
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    BOOL shouldEnd = YES;
    if ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        shouldEnd = [self.delegate textFieldShouldEndEditing:self];
    }
    if (shouldEnd) {
        if (textField.text.length == 0) {
            [UIView animateWithDuration:.25f animations:^{
                [self zoomHint];
                _hintImage.alpha = !isErrorShow;
                _focusImage.alpha = 0.f;
                _errorImage.alpha = isErrorShow;
                _line.sd_layout.heightIs(0.5f);
                _line.backgroundColor = _showLine?(isErrorShow?_errorColor:_lineColor):[UIColor clearColor];
            }];
        }else{
            [UIView animateWithDuration:.25f animations:^{
                _hintImage.alpha = !isErrorShow;
                _focusImage.alpha = 0.f;
                _errorImage.alpha = isErrorShow;
                _line.sd_layout.heightIs(0.5f);
                _line.backgroundColor = _showLine?(isErrorShow?_errorColor:_lineColor):[UIColor clearColor];
            }];
        }
        
    }
    return shouldEnd;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    isFocused = NO;
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0){
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        [self.delegate textFieldDidEndEditing:self reason:reason];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self showFocused];
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:self];
    }
    return YES;
}


@end
