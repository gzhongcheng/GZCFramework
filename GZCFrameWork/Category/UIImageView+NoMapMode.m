//
//  UIImageView+NoMapMode.m
//  Shop
//
//  Created by GuoZhongCheng on 16/1/6.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIImageView+NoMapMode.h"
#import "AFNetworking.h"
#import "GZCConstant.h"

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

-(void)setWebImage:(NSString *)image completed:(SDWebImageCompletionBlock)completedBlock{
    [self setWebImage:nil image:image placeholderImage:nil completed:completedBlock];
}

-(void)setWebImage:(NSString *)image placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock{
    [self setWebImage:nil image:image placeholderImage:placeholder completed:completedBlock];
}

-(void)setWebImage:(NSString *)baseUrl image:(NSString *)image placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock{
    BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:kNoMapMode] boolValue];
    if(on && ![[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi])    {
        [self setImage:mainPlaceHolderImage];
    }
    else
    {
        NSString* url = nil;
        if(baseUrl)
            url = [baseUrl stringByAppendingString:image];
        else
            url = image;
        //        [self sd_cancelCurrentImageLoad];
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:completedBlock];
    }
}


@end
