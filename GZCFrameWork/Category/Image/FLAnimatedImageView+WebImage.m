//
//  FLAnimatedImageView+WebImage.m
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/7/1.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "FLAnimatedImageView+WebImage.h"
#import "AFNetworking.h"
#import "ProjectMacros.h"
#import "UIImage+RenderedImage.h"

@implementation FLAnimatedImageView (WebImage)

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
    if ([url rangeOfString:@".gif"].location != NSNotFound) {
        NSURL *URL = [NSURL URLWithString:url];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        NSData *imageData = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
#pragma clang diagnostic pop
        if (imageData == nil) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL
                                                                  options:0
                                                                 progress:nil
                                                                completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                    [[[SDWebImageManager sharedManager]imageCache]storeImageDataToDisk:data
                                                                                                                                forKey:URL.absoluteString];
                                                                    kDISPATCH_MAIN_BLOCK(^{
                                                                        FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:data];
                                                                        self.animatedImage   = gifImage;
                                                                    });
                                                                }];
        }else{
            kDISPATCH_MAIN_BLOCK(^{
                FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
                self.animatedImage   = gifImage;
            });
        }
        
    }else{
        BOOL on = [[[NSUserDefaults standardUserDefaults] objectForKey:kNoMapMode] boolValue];
        if (placeholder == nil) {
            placeholder = [UIImage imageWithRenderColor:mainLineColor renderSize:CGSizeMake(1, 1)];
        }
        if(on && ![[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi])    {
            [self setImage:placeholder];
        }
        else
        {
            [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:completedBlock];
        }
    }
}

@end
