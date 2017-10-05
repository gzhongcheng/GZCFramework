//
//  UIView+Sound.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/21.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import "UIView+Sound.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation UIView(Sound)

-(void)soundResourceNamed:(NSString *)soundName ofType:(NSString *)type{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundName ofType:type]];
    [self soundResourcePath:url];
}

-(void)soundResourcePath:(NSURL *)path{
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)path, &soundId);
    AudioServicesPlaySystemSound(soundId);
}

@end
