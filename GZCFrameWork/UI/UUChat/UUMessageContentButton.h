//
//  UUMessageContentButton.h
//  BloodSugarForDoc
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUMessageContentButton : UIButton

//bubble imgae
@property (nonatomic, retain) UIImageView *backImageView;

//audio
@property (nonatomic, retain) UIView *voiceBackView;
@property (nonatomic, retain) UILabel *second;
@property (nonatomic, retain) UIImageView *voice;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

//链接
@property (nonatomic, strong) UIImageView * linkImageView;
@property (nonatomic, strong) UILabel * linkLabel;      
@property (nonatomic, copy) NSString * link;     //点击的链接

@property (nonatomic, assign) BOOL isMyMessage;


- (void)benginLoadVoice;

- (void)didLoadVoice;

-(void)stopPlay;

@end
