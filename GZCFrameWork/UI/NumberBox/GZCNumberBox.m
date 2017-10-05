//
//  GZCNumberBox.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/8/29.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCNumberBox.h"
#import "ProjectMacros.h"
#import "SDAutoLayout.h"

@interface GZCNumberBox()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *cutButton;
@property (nonatomic,strong) UIButton *addButton;

@end

@implementation GZCNumberBox

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefine];
    }
    return self;
}



-(void)setupDefine{
    self.borderWidth = 1.f;
    self.borderColor = mainLineColor;
    self.cornerRadius = 0;
    self.spacing = 0;
    self.clickableColor = KGrayColor;
    self.minNumber = 1;
    self.maxNumber = 10;
    self.number = 0;
    self.focuseAble = YES;
    [self sendSubviewToBack:self.textField];
}

-(void)configLayout{
    self.cutButton.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .widthIs(self.height);
    
    self.addButton.sd_layout
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .widthIs(self.height);
    
    self.textField.sd_layout
    .leftSpaceToView(self.cutButton, _spacing)
    .rightSpaceToView(self.addButton, _spacing)
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0);
    
    
    _textField.font = SYSTEMFONT(self.height*0.6f);
    _addButton.titleLabel.font = SYSTEMFONT(self.height*0.8f);
    _cutButton.titleLabel.font = SYSTEMFONT(self.height*0.8f);
}

#pragma mark - target
-(void)addTaped{
    int old = [_textField.text intValue];
    old ++;
    [self setNumber:old];
}

-(void)cutTaped{
    int old = [_textField.text intValue];
    old --;
    [self setNumber:old];
}

#pragma mark - getter
-(UITextField *)textField{
    if (_textField == nil) {
        self.textField = [[UITextField alloc]init];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.textColor = mainFontColor;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        [self addSubview:_textField];
    }
    return _textField;
}

-(UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitleColor:_clickableColor forState:UIControlStateNormal];
        [_addButton setTitleColor:_borderColor forState:UIControlStateDisabled];
        [_addButton  setTitle:@"＋" forState:UIControlStateNormal];
        [_addButton addTarget: self action:@selector(addTaped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
    }
    return _addButton;
}

-(UIButton *)cutButton{
    if (_cutButton == nil) {
        self.cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cutButton setTitleColor:_clickableColor forState:UIControlStateNormal];
        [_cutButton setTitleColor:_borderColor forState:UIControlStateDisabled];
        [_cutButton setTitle:@"－" forState:UIControlStateNormal];
        [_cutButton addTarget: self action:@selector(cutTaped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cutButton];
    }
    return _cutButton;
}

#pragma mark - setter
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self configLayout];
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.textField.layer.borderColor = borderColor.CGColor;
    self.cutButton.layer.borderColor = borderColor.CGColor;
    self.addButton.layer.borderColor = borderColor.CGColor;
    [_cutButton setTitleColor:_borderColor forState:UIControlStateDisabled];
    [_addButton setTitleColor:_borderColor forState:UIControlStateDisabled];
}

-(void)setBorderWidth:(float)borderWidth{
    _borderWidth = borderWidth;
    self.textField.layer.borderWidth = borderWidth;
    self.cutButton.layer.borderWidth = borderWidth;
    self.addButton.layer.borderWidth = borderWidth;
}

-(void)setCornerRadius:(float)cornerRadius{
    _cornerRadius = cornerRadius;
    self.textField.layer.cornerRadius = cornerRadius;
    self.cutButton.layer.cornerRadius = cornerRadius;
    self.addButton.layer.cornerRadius = cornerRadius;
}

-(void)setSpacing:(float)spacing{
    _spacing = spacing;
    self.textField.sd_layout
    .leftSpaceToView(self.cutButton, _spacing)
    .rightSpaceToView(self.addButton, _spacing);
}

-(void)setClickableColor:(UIColor *)clickableColor{
    _clickableColor = clickableColor;
    [_cutButton setTitleColor:_clickableColor forState:UIControlStateNormal];
    [_addButton setTitleColor:_clickableColor forState:UIControlStateNormal];
    [self setEnable:_cutButton.enabled toButton:_cutButton];
    [self setEnable:_addButton.enabled toButton:_addButton];
}

-(void)setNumber:(int)number{
    BOOL shouldChange = YES;
    if ([self.delegate respondsToSelector:@selector(GZCNumberBox:numberWillChange:)]) {
        shouldChange = [self.delegate GZCNumberBox:self numberWillChange:number];
    }
    if (!shouldChange) {
        return;
    }
    [self setEnable:YES toButton:_cutButton];
    [self setEnable:YES toButton:_addButton];
    if (number<=_minNumber) {
        [self setEnable:NO toButton:_cutButton];
        number = _minNumber;
    }else if (number>=_maxNumber){
        [self setEnable:NO toButton:_addButton];
        number = _maxNumber;
    }
    _number = number;
    _textField.text = [NSString stringWithFormat:@"%d",number];
    if ([self.delegate respondsToSelector:@selector(GZCNumberBox:numberDidChange:)]) {
        [self.delegate GZCNumberBox:self numberDidChange:number];
    }
}

-(void)setEnable:(BOOL)enable
        toButton:(UIButton*)button{
    button.enabled = enable;
    if (enable) {
        button.layer.borderColor = _clickableColor.CGColor;
    }else{
        button.layer.borderColor = _borderColor.CGColor;
    }
}

#pragma mark - textfielddelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return _focuseAble;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]&&textField.text.length == 1) {
        textField.text = @"0";
        return NO;
    }
    BOOL shouldChanged = [self validateNumber:string];
    if ([textField.text isEqualToString:@"0"]&&shouldChanged) {
        textField.text = @"";
    }
    return shouldChanged;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self setNumber:[textField.text intValue]];
}


- (BOOL)validateNumber:(NSString*)string {
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    return basicTest;
}


@end
