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

//服务器验证密钥
#define MS_AK @""
#define MS_SK @""

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
#define API_HOST @""
#define API_PAY_HOST @""

#elif TestSever

/**测试服务器*/
#define API_HOST @""
#define API_PAY_HOST @""

#elif ProductSever

/**生产服务器*/
#define API_HOST @""
#define API_PAY_HOST @""

#endif

#pragma mark - 详细接口地址

//      接口路径全拼
#define PATH(_path)             [NSString stringWithFormat:@"%@%@", API_HOST,@#_path]
#define APIPATH(_path)             [NSString stringWithFormat:@"%@app_api/%@", API_HOST,@#_path]
#define PAYPATH(_path)             [NSString stringWithFormat:@"%@%@", API_PAY_HOST,@#_path]

//返回原生界面
#define PATH_BACK     PATH(can_not_go_back)

//接口常数
#define PATH_LOGIN    PATH()
#define PATH_HOME     PATH()
#define PATH_USER     PATH()
#define PATH_WXPAY    PATH()

#endif /* URLMacros_h */
