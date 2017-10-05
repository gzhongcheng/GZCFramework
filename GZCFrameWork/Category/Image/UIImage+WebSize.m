//
//  UIImage+WebSize.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/19.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import "UIImage+WebSize.h"
#import "UIImageView+WebCache.h"
#import "KHIFastImage.h"
#import "GCDQueue.h"

@implementation UIImage(WebSize)

#define DefoultWebImageWidth 0
#define DefoultWebImageHeight 0

#pragma mark - 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
               asynsDownLoad:(BOOL)asynsDownload
         dowmLoaderCompleted:(GZCImageSizeDownloaderCompletedBlock)completedBlock
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeMake(DefoultWebImageWidth, DefoultWebImageHeight);                  // url不正确返回默认高度
    
    NSString *key = [[SDWebImageManager sharedManager]cacheKeyForURL:URL];
    //判断是否存在缓存里
    UIImage* image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    if(image!=nil)
    {
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:key];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        if (asynsDownload) {
            //异步下载图片
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:URL options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                completedBlock(image,image.size,error,finished);
            }];
        }else{
            //直接下载图片并保存到缓存
            NSData *data =  [NSData dataWithContentsOfURL:URL];//[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
            UIImage* image = [UIImage imageWithData:data];
            if(image)
            {
                [[SDImageCache sharedImageCache]storeImageDataToDisk:data forKey:key];
                return image.size;
            }
        }
    }else{
        return size;
    }
    size = CGSizeZero;
    //返回默认高度
    return size;
}

+(float)getImageHeightWithUrl:(id)imageURL
                   imageWidth:(float)width
                asynsDownLoad:(BOOL)asynsDownload
          dowmLoaderCompleted:(GZCImageHeightDownloaderCompletedBlock)completedBlock{
    CGSize imgsize = [self getImageSizeWithURL:imageURL asynsDownLoad:asynsDownload dowmLoaderCompleted:^(UIImage *image, CGSize size, NSError *error, BOOL finished) {
        float height = 0;
        if (size.width>width) {
            height = size.height/(size.width/width);
        }
        else
        {
            height = size.height*(width/size.width);
        }
        completedBlock(image,height,error,finished);
    }];
    if (imgsize.width>width) {
        return imgsize.height/(imgsize.width/width);
    }
    else
    {
        return imgsize.height*(width/imgsize.width);
    }
}

//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self sizeForJPEGWithData:data];
}

#define _FIValueBetween(value, min, max) ({ \
__typeof__(value) __value = (value); \
__typeof__(min) __min = (min); \
__typeof__(max) __max = (max); \
__value >= __min && __value <= __max; \
})

+ (CGSize)sizeForJPEGWithData:(NSData *)data
{
    // JPEG parsing is a bit more elaborate then the others as the data we're looking for comes after
    // many different variably-sized data structures
    //
    // ELI5: JPEG file data structure includes a bunch of headers which mark certain type of info,
    // we want to find the header that holds the size.
    
    typedef NS_ENUM(NSInteger, _FIJPEGState) {
        _FIJPEGStateFindHeader,
        _FIJPEGStateDetermineFrameType,
        _FIJPEGStateSkipFrame,
        _FIJPEGStateFoundSOF,
        _FIJPEGStateFoundEOI
    };
    
    // Note: Height data comes before width data.  Also both are big-endian
    struct {
        UInt16 height; // Big-endian
        UInt16 width; // Big-endian
    } jpeg_size;
    
    // Start at offset 2 (knowing we already passed the first two bytes determining that this is a JPEG file)
    _FIJPEGState state = _FIJPEGStateFindHeader;
    UInt32 offset = 2;
    
    // Loop until we find what we want
    while (offset < data.length) {
        switch (state) {
                
            case _FIJPEGStateFindHeader: {
                // Find a table header. These are denoted by the bytes `FFXX`, where XX denotes the type of data in that
                // data table. If we parse this correctly, this loop will only run once.
                
                UInt8 sample = 0;
                while (sample != 0xFF) {
                    if (offset < data.length) {
                        [data getBytes:&sample range:NSMakeRange(offset, 1)];
                        offset++;
                    } else {
                        // If we parsed the whole chuck of data and couldn't find it?...
                        // Not enough data or a corrupted JPEG. Should error out here
                        return CGSizeZero;
                    }
                }
                
                // Move to determine the type of the table
                state = _FIJPEGStateDetermineFrameType;
                break;
            }
                
            case _FIJPEGStateDetermineFrameType: {
                // We've found a data marker, now we determine what type of data we're looking at.
                // FF E0 -> FF EF are 'APPn', and include lots of metadata like JFIF, EXIF, etc.
                //
                // What we want to find is one of the SOF (Start of Frame) header, cause' it includes
                // width and height (what we want!)
                //
                // JPEG Metadata Header Table
                // http://www.xbdev.net/image_formats/jpeg/tut_jpg/jpeg_file_layout.php
                //
                // Start of Frame headers:
                //
                //    FF C0 - SOF0  - Baseline
                //    FF C1 - SOF1  - Extended sequential
                //    FF C2 - SOF2  - Progressive
                //    FF C3 - SOF3  - Loseless
                //
                //    FF C5 - SOF5  - Differential sequential
                //    FF C6 - SOF6  - Differential progressive
                //    FF C7 - SOF7  - Differential lossless
                //    FF C9 - SOF9  - Extended sequential, arithmetic coding
                //
                //    FF CA - SOF10 - Progressive, arithmetic coding
                //    FF CB - SOF11 - Lossless, arithmetic coding
                //
                //    FF CD - SOF13 - Differential sequential, arithmetic coding
                //    FF CE - SOF14 - Differential progressive, arithmetic coding
                //    FF CF - SOF15 - Differential lossless, arithmetic coding
                //
                // Each of these SOF data markers have the same data structure:
                // struct {
                //   UInt16 header; // e.g. FFC0
                //   UInt16 frameLength;
                //   UInt8 samplePrecision;
                //   UInt16 imageHeight;
                //   UInt16 imageWidth;
                //   ... // we only care about this part
                // }
                
                UInt8 sample = 0;
                [data getBytes:&sample range:NSMakeRange(offset, 1)];
                offset++;
                
                // Technically we should check if this has EXIF data here (looking for FFE1 marker)…
                // Maybe TODO later
                if (_FIValueBetween(sample, 0xE0, 0xEF)) {
                    state = _FIJPEGStateSkipFrame;
                    
                } else if (_FIValueBetween(sample, 0xC0, 0xC3) ||
                           _FIValueBetween(sample, 0xC5, 0xC7) ||
                           _FIValueBetween(sample, 0xC9, 0xCB) ||
                           _FIValueBetween(sample, 0xCD, 0xCF)) {
                    state = _FIJPEGStateFoundSOF;
                    
                } else if (sample == 0xFF) {
                    state = _FIJPEGStateDetermineFrameType;
                    
                } else if (sample == 0xD9) {
                    // We made it to the end of the file somehow without finding the size? Likely a corrupt file
                    state = _FIJPEGStateFoundEOI;
                    
                } else {
                    // Since we don't handle every header case default to skipping an unknown data marker
                    state = _FIJPEGStateSkipFrame;
                    
                }
                
                break;
            }
                
            case _FIJPEGStateSkipFrame: {
                UInt16 frameLength = 0;
                [data getBytes:&frameLength range:NSMakeRange(offset, 2)];
                frameLength = CFSwapInt16BigToHost(frameLength);
                
                offset += (frameLength - 1);
                state = _FIJPEGStateFindHeader;
                break;
            }
                
            case _FIJPEGStateFoundSOF: {
                offset += 3; // Skip the frame length and sample precision, see above ^
                [data getBytes:&jpeg_size range:NSMakeRange(offset, 4)];
                return CGSizeMake(CFSwapInt16BigToHost(jpeg_size.width), CFSwapInt16BigToHost(jpeg_size.height));
            }
                
            case _FIJPEGStateFoundEOI: {
                return CGSizeZero;
            }
        }
    }
    
    return CGSizeZero;
}

@end
