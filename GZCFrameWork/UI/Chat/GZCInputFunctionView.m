//
//  GZCInputFunctionView.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/25.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCInputFunctionView.h"
#import "Mp3Recorder.h"
#import "UUProgressHUD.h"
#import "GZCFramework.h"
#import "FacialView.h"

#define Main_Screen_Height mainHeight
#define Main_Screen_Width mainWidth
#define  keyboardHeight 216
#define  facialViewWidth mainWidth-40
#define facialViewHeight 170

@interface GZCInputFunctionView ()<UITextViewDelegate,Mp3RecorderDelegate,facialViewDelegate,UIScrollViewDelegate>
{
    BOOL isbeginVoiceRecord;
    BOOL isbeginChooseOther;
    BOOL isbeginChooseEmjoy;
    Mp3Recorder *MP3;
    NSInteger playTime;
    NSTimer *playTimer;
    
    UILabel *placeHold;
    UIScrollView *scrollView;//表情滚动视图
    UIPageControl *pageControl;
}
@end

@implementation GZCInputFunctionView

- (id)initWithSuperVC:(UIViewController *)superVC
{
    self.superVC = superVC;
    CGRect frame = CGRectMake(0, Main_Screen_Height-50, Main_Screen_Width, 50);
    
    self = [super initWithFrame:frame];
    if (self) {
        MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
        self.backgroundColor = [UIColor whiteColor];
        //选择其它
        self.btnChooseOther = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChooseOther.frame = CGRectMake(Main_Screen_Width-40, (HEIGHT(self)-30)/2, 30, 30);
        isbeginChooseOther = NO;
        [self.btnChooseOther setTitle:@"" forState:UIControlStateNormal];
        [self.btnChooseOther setBackgroundImage:[UIImage imageNamed:@"chat_choose_other"] forState:UIControlStateNormal];
        self.btnChooseOther.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChooseOther addTarget:self action:@selector(chooseOther:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChooseOther];
        
        //选择表情
        self.btnChooseEmjoy = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChooseEmjoy.frame = CGRectMake(Main_Screen_Width-75, (HEIGHT(self)-30)/2, 30, 30);
        isbeginChooseEmjoy = NO;
        [self.btnChooseEmjoy setTitle:@"" forState:UIControlStateNormal];
        [self.btnChooseEmjoy setBackgroundImage:[UIImage imageNamed:@"chat_choose_emjoy"] forState:UIControlStateNormal];
        self.btnChooseEmjoy.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChooseEmjoy addTarget:self action:@selector(chooseEmjoy:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChooseEmjoy];
        
        //创建表情键盘
        if (scrollView==nil) {
            scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHT(superVC.view), mainWidth, keyboardHeight)];
            [scrollView setBackgroundColor:[UIColor whiteColor]];
            for (int i=0; i<9; i++) {
                FacialView *fview=[[FacialView alloc] initWithFrame:CGRectMake(20+mainWidth*i, 15, facialViewWidth, facialViewHeight)];
                [fview setBackgroundColor:[UIColor clearColor]];
                [fview loadFacialView:i size:CGSizeMake(33, 43)];
                fview.delegate=self;
                [scrollView addSubview:fview];
            }
        }
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        scrollView.contentSize=CGSizeMake(mainWidth*9, keyboardHeight);
        scrollView.pagingEnabled=YES;
        scrollView.delegate=self;
        [superVC.view addSubview:scrollView];
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(98, HEIGHT(superVC.view)-40  , 150, 30)];
        [pageControl setCurrentPage:0];
        pageControl.pageIndicatorTintColor=BG_COLOR;
        pageControl.currentPageIndicatorTintColor=mainColor;
        pageControl.numberOfPages = 9;//指定页面个数
        [pageControl setBackgroundColor:[UIColor clearColor]];
        pageControl.hidden=YES;
        [superVC.view addSubview:pageControl];
        
        
        //改变状态（语音、文字）
        self.btnChangeVoiceState = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChangeVoiceState.frame = CGRectMake(5, (HEIGHT(self)-30)/2, 30, 30);
        isbeginVoiceRecord = NO;
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        self.btnChangeVoiceState.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChangeVoiceState addTarget:self action:@selector(voiceRecord:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChangeVoiceState];
        
        //语音录入键
        self.btnVoiceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnVoiceRecord.frame = CGRectMake(45, (HEIGHT(self)-30)/2, Main_Screen_Width-2*45-40, 30);
        self.btnVoiceRecord.hidden = YES;
        [self.btnVoiceRecord setBackgroundImage:[UIImage imageNamed:@"chat_message_back"] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [self.btnVoiceRecord setTitle:@"长按 说话" forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:self.btnVoiceRecord];
        
        //输入框
        self.TextViewInput = [[UITextView alloc]initWithFrame:CGRectMake(45, (HEIGHT(self)-30)/2, Main_Screen_Width-2*45-40, 30)];
        self.TextViewInput.layer.cornerRadius = 4;
        self.TextViewInput.layer.masksToBounds = YES;
        self.TextViewInput.delegate = self;
        self.TextViewInput.layer.borderWidth = 1;
        self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.TextViewInput];
        
        //输入框的提示语
        placeHold = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
        placeHold.text = @"输入文字内容";
        placeHold.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self.TextViewInput addSubview:placeHold];
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}



#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    [MP3 startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"取消"];
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Release to cancel"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Slide up to cancel"];
}


- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}


#pragma mark - Mp3RecorderDelegate

//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate GZCInputFunctionView:self sendVoice:voiceData time:playTime+1];
    [UUProgressHUD dismissWithSuccess:@"录音结束"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"太短了"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

//改变输入与录音状态
- (void)voiceRecord:(UIButton *)sender
{
    isbeginVoiceRecord = !isbeginVoiceRecord;
    if (isbeginVoiceRecord) {
        [self beginVoice];
    }else{
        [self endVoice];
        [self.TextViewInput becomeFirstResponder];
    }
}

-(void)beginVoice{
    self.btnVoiceRecord.hidden = NO;
    self.TextViewInput.hidden  = YES;
    [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
    [self hideEmjoy];
    [self.TextViewInput resignFirstResponder];
    isbeginVoiceRecord = YES;
}

-(void)endVoice{
    self.btnVoiceRecord.hidden = YES;
    self.TextViewInput.hidden  = NO;
    [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
    isbeginVoiceRecord = NO;
}

//显示表情选择
-(void)chooseEmjoy:(UIButton *)sender{
    isbeginChooseEmjoy = !isbeginChooseEmjoy;
    if (isbeginChooseEmjoy) {
        [self showEmjoy];
    }else{
        [self hideEmjoy];
        [self.TextViewInput becomeFirstResponder];
    }
}

-(void)showEmjoy{
    [self.btnChooseEmjoy setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
    //键盘显示的时候，toolbar需要还原到正常位置，并显示表情
    [self.TextViewInput resignFirstResponder];
    [self endVoice];
    [UIView animateWithDuration:.25f animations:^{
        [scrollView setFrame:CGRectMake(0, HEIGHT(self.superVC.view) - keyboardHeight ,mainWidth, keyboardHeight)];
        self.frame = CGRectMake(MinX(self), MinY(self)-keyboardHeight, WIDTH(self), HEIGHT(self));
    }];
    [pageControl setHidden:NO];
    isbeginChooseEmjoy = YES;
}

-(void)hideEmjoy{
    if (isbeginChooseEmjoy) {
        [self hideEmjoyWithKeyBoard:NO];
    }
}

-(void)hideEmjoyWithKeyBoard:(BOOL)showsKey{
    [UIView animateWithDuration:.25f animations:^{
        [scrollView setFrame:CGRectMake(0, HEIGHT(self.superVC.view) ,WIDTH(self.superVC.view), keyboardHeight)];
        if (!showsKey) {
            self.frame = CGRectMake(MinX(self), MinY(self)+keyboardHeight, WIDTH(self), HEIGHT(self));
        }
    }];
    [pageControl setHidden:YES];
    [self.btnChooseEmjoy setBackgroundImage:[UIImage imageNamed:@"chat_choose_emjoy"] forState:UIControlStateNormal];
    isbeginChooseEmjoy = NO;
}

//显示其它选项
-(void)chooseOther:(UIButton *)sender{
    [self.TextViewInput resignFirstResponder];
    UIActionSheet *actionSheet= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选择",nil];
    [actionSheet showInView:self.window];
}

#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (isbeginChooseEmjoy) {
        [self hideEmjoyWithKeyBoard:YES];
    }
    placeHold.hidden = self.TextViewInput.text.length > 0;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        
        NSString *resultStr = [self.TextViewInput.text stringByReplacingOccurrencesOfString:@"   " withString:@""];
        [self.delegate GZCInputFunctionView:self sendMessage:resultStr];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    placeHold.hidden = textView.text.length>0;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    placeHold.hidden = self.TextViewInput.text.length > 0;
}


#pragma mark - Add Picture
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addCarema];
    }else if (buttonIndex == 1){
        [self openPicLibrary];
    }
}

-(void)addCarema{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未找到照相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:picker animated:YES completion:^{
        }];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.superVC dismissViewControllerAnimated:YES completion:^{
        [self.delegate GZCInputFunctionView:self sendPicture:editImage];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.superVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark -
#pragma mark endediting

-(BOOL)endEditing:(BOOL)force{
    return [super endEditing:force];
}

#pragma mark - scrollview delegage
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    pageControl.currentPage = page;//pagecontroll响应值的变化
}

#pragma mark facialView delegate 点击表情键盘上的文字
-(void)selectedFacialView:(NSString*)str
{
    NSString *newStr;
    if ([str isEqualToString:@"删除"]) {
        if (_TextViewInput.text.length>0) {
            if (_TextViewInput.text.length>=2&&[[Emoji allEmoji] containsObject:[_TextViewInput.text substringFromIndex:_TextViewInput.text.length-2]]) {
                newStr=[_TextViewInput.text substringToIndex:_TextViewInput.text.length-2];
            }else{
                newStr=[_TextViewInput.text substringToIndex:_TextViewInput.text.length-1];
            }
            _TextViewInput.text=newStr;
        }
    }else{
        NSString *newStr=[NSString stringWithFormat:@"%@%@",_TextViewInput.text,str];
        [_TextViewInput setText:newStr];
    }
    placeHold.hidden = self.TextViewInput.text.length>0;
}

@end