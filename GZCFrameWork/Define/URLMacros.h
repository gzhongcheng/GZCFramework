//
//  URLMacros.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

//  项目接口


#ifndef URLMacros_h
#define URLMacros_h

#define MS_AK @"Y23tUTNHQ0xOd2ZDQzZC"
#define MS_SK @"Rk1Stm32QWxYZVVONVlv"

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define API_HOST @"http://www.nenyimall.com/"
#define API_PAY_HOST @"http://pay.nenyimall.com/pay/wxpay/"

#elif TestSever

/**测试服务器*/
#define API_HOST @"http://192.168.16.117:8007/"
#define API_PAY_HOST @"http://pay.nenyimall.com/pay/wxpay/"

#elif ProductSever

/**生产服务器*/
#define API_HOST @"http://www.wokanw.com/"
#define API_PAY_HOST @"http://pay.nenyimall.com/pay/wxpay/"

#endif

#pragma mark - 详细接口地址

//      接口路径全拼
#define PATH(_path)             [NSString stringWithFormat:@"%@%@", API_HOST,@#_path]
#define APIPATH(_path)             [NSString stringWithFormat:@"%@app_api/%@", API_HOST,@#_path]
#define PAYPATH(_path)             [NSString stringWithFormat:@"%@%@", API_PAY_HOST,@#_path]

#define PATH_BACK     PATH(can_not_go_back)

#define PATH_LOGIN    PATH(?m=member&act=show_login)
#define PATH_GOODS    PATH(products_content.asp?id=)
#define PATH_HOME     PATH()
#define PATH_PROJECT  PATH((?m=project&act=show_list))
#define PATH_UPGRADE  PATH(user_up.asp)
#define PATH_USER     PATH(user_center.asp)
#define PATH_WXPAY    PATH(wxpayok.asp?)

#endif /* URLMacros_h */
