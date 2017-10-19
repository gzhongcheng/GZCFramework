//
//  GZCAlertView.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/13.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "LEEAlert.h"
#import "GZCAlertHandle.h"

typedef void (^NoticeDoneBlock)(void);
typedef void (^NoticeCloseBlock)(void);

@interface GZCAlertView : LEEAlert

/**
 系统风格的ActionSheet

 @param title 标题
 @param buttons 按钮标题的Array,每个按钮的格式如下：
                         @{
                             @"title" : @"微信" ,       //标题
                             @"title_color" : @"ffffff"  //标题颜色
                         }
 @param targetBlock 按钮点击回调（点取消时不会回调）
 */
+ (void)showActionSheetWithTitle:(NSString *)title
                         buttons:(NSArray *)buttons
                           block:(void (^)(NSInteger index,NSString *title))targetBlock;

/**
 显示系统自带风格的提示框
 
 @param config GZCAlertHandle设置标题等信息
 @param targetBlock 按钮回调 （顺序为done 0 ， cancel 1）
 */
+ (void)showAlertViewWithConfig:(GZCAlertHandle *)config
                      doneBlock:(void (^)(NSInteger index,NSString *title))targetBlock;

/**
 微信风格的ActionSheet
 
 @param title 标题
 @param buttons 按钮标题的Array,每个按钮的格式如下：
                         @{
                             @"title" : @"微信" ,       //标题
                             @"title_color" : @"ffffff"  //标题颜色
                         }
 @param doneBlock 按钮点击回调（点取消时不会回调）
 */
+ (void)showWXSheetWithTitle:(NSString *)title
                     buttons:(NSArray *)buttons
                       block:(void (^)(NSInteger index,NSString *title))doneBlock;


/**
 显示分享界面(ActionSheet样式)
 
 @param infoArray 按钮数据，每个按钮对应的数据单元格式如下：
                             @{
                                 @"title" : @"微信" ,       //标题
                                 @"image" : @"" ,            //网络图片地址或者本地图片名称
                                 @"highlightedImage" : @"" , //网络图片地址或者本地图片名称
                                 @"tag" : @"微信"             //点击回调标识符
                             }
 @param maxLineNumber 最大行数
 @param maxSingleCount 每行显示的最大个数
 @param shareBlock 点击的回调
 */
+ (void)showShareSheetWithInfoArray:(NSArray *)infoArray
                      MaxLineNumber:(NSInteger)maxLineNumber
                     MaxSingleCount:(NSInteger)maxSingleCount
                              block:(void (^)(NSInteger index,NSString *tag))shareBlock;

;

/**
 显示分享界面(AlertView样式)

 @param infoArray 按钮数据，每个按钮对应的数据单元格式如下：
                             @{
                                @"title" : @"微信" ,       //标题
                                @"image" : @"" ,            //网络图片地址或者本地图片名称
                                @"highlightedImage" : @"" , //网络图片地址或者本地图片名称
                                @"tag" : @"微信"             //点击回调标识符
                             }
 @param maxLineNumber 最大行数
 @param maxSingleCount 每行显示的最大个数
 @param shareBlock 点击的回调
 */
+ (void)showShareAlertWithInfoArray:(NSArray *)infoArray
                      MaxLineNumber:(NSInteger)maxLineNumber
                     MaxSingleCount:(NSInteger)maxSingleCount
                              block:(void (^)(NSInteger index,NSString *tag))shareBlock;


/**
 显示分享界面
 */
+ (void)showShareAlert;

/**
 签到成功界面

 @param prizeURL 奖品图片链接（本地图片名称／网络图片链接）
 @param sroce 奖品数量（如：@"+1"）
 @param day 连续／累计签到天数 ，请传入完整句子，如@"已经成功签到1天"
 @param desc 奖品说明
 @param doneTitle 确定按钮标题
 @param doneBlock 确定按钮回调，如果是直接消失，可以传nil
 */
+ (void)showQiandaoSuccessWithPrize:(NSString *)prizeURL
                              sroce:(NSString *)sroce
                                day:(NSString *)day
                               desc:(NSString *)desc
                          doneTitle:(NSString *)doneTitle
                          doneBlock:(NoticeDoneBlock)doneBlock;

/**
 签到成功界面
 */
+ (void)showQiandaoSuccess;

/**
 图文提醒

 @param imageURL 图片链接（本地图片名称/网络图片地址）
 @param title 标题
 @param content 内容
 @param doneTitle 确定按钮标题
 @param doneBlock 确定按钮回调
 @param closeBlock 关闭按钮回调
 */
+ (void)showNoticeWithImage:(NSString *)imageURL
                      title:(NSString *)title
                    content:(NSString *)content
                  doneTitle:(NSString *)doneTitle
                  doneBlock:(NoticeDoneBlock)doneBlock
                 closeBlock:(NoticeCloseBlock)closeBlock;

/**
 提示用户开启推送
 */
+ (void)showPushNotice;

@end
