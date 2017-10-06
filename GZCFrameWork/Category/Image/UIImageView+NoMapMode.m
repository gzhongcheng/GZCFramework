//
//  UIImageView+NoMapMode.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/1/6.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIImageView+NoMapMode.h"
//#import "AFNetworking.h"
#import "ProjectMacros.h"
#import "UIImage+RenderedImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (NoMapMode)

-(void)setWebImage:(NSString *)image{
    [self setWebImage:nil image:image placeholderImage:nil completed:nil];
}

- (void)setWebImage:(NSString *)image placeholderImage:(UIImage *)placeholder{
    [self setWebImage:nil image:image placeholderImage:placeholder completed:nil];
}

- (void)setWebImage:(NSString *)baseUrl image:(NSString *)image
{
    [self setWebImage:baseUrl image:image placeholderImage:nil completed:nil];
}

- (void)setWebImage:(NSString *)baseUrl image:(NSString *)image placeholderImage:(UIImage *)placeholder{
    [self setWebImage:baseUrl image:image placeholderImage:placeholder completed:nil];
}

-(void)setWebImage:(NSString *)image completed:(SDExternalCompletionBlock)completedBlock{
    [self setWebImage:nil image:image placeholderImage:nil completed:completedBlock];
}

-(void)setWebImage:(NSString *)image placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock{
    [self setWebImage:nil image:image placeholderImage:placeholder completed:completedBlock];
}

-(void)setWebImage:(NSString *)baseUrl image:(NSString *)image placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock{
    NSString* url = nil;
    if(baseUrl)
        url = [baseUrl stringByAppendingString:image];
    else
        url = image;
    if (([url isEqualToString:@""] || image == nil)) {
        [self setImage:nil];
        return;
    }
    if (![url hasPrefix:@"http"]) {
        [self setImage:[UIImage imageNamed:image]];
        return;
    }
//    BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:kNoMapMode] boolValue];
    if (placeholder == nil) {
        placeholder = [UIImage imageWithRenderColor:KClearColor renderSize:CGSizeMake(1, 1)];
    }
//    if(on && ![[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi])    {
//        [self setImage:placeholder];
//    }
//    else
//    {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:completedBlock];
//    }
}


@end
