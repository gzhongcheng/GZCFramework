//
//  UIImage+WebSize.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/19.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(WebSize)

typedef void(^GZCImageSizeDownloaderCompletedBlock)(UIImage * image, CGSize size, NSError * error, BOOL finished);
typedef void(^GZCImageHeightDownloaderCompletedBlock)(UIImage * image, float height, NSError * error, BOOL finished);


/**
 根据图片链接获取图片的size

 @param imageURL 图片链接
 @param asynsDownload 是否要异步下载图片，如果为NO，则会用同步下载图片（可能会花较长时间）
 @param completedBlock 异步下载图片的回调
 @return 图片大小（如果获取失败，会返回 CGSizeZero,同时异步下载图片,并在下载完成后回调completedBlock）
 */
+(CGSize)getImageSizeWithURL:(id)imageURL
               asynsDownLoad:(BOOL)asynsDownload
         dowmLoaderCompleted:(GZCImageSizeDownloaderCompletedBlock)completedBlock;


/**
 根据图片链接以及图片控件宽度进行等比例缩放获取图片的高度

 @param imageURL 图片链接
 @param width 限制宽度
 @param asynsDownload 是否要异步下载图片，如果为NO，则会用同步下载图片（可能会花较长时间）
 @param completedBlock 异步下载图片的回调
 @return 等比缩放后的高度（如果获取失败，会返回 0,同时异步下载图片,并在下载完成后回调completedBlock）
 */
+(float)getImageHeightWithUrl:(id)imageURL
                   imageWidth:(float)width
                asynsDownLoad:(BOOL)asynsDownload
          dowmLoaderCompleted:(GZCImageHeightDownloaderCompletedBlock)completedBlock;

@end
