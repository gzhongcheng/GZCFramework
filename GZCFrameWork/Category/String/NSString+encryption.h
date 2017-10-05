//
//  NSString+md5.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/21.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(encryption)

#pragma mark - URL

/**
 UrlEncode编码
 对URL中的中文进行编码
 @return 编码后的字符串
 */
- (NSString*)urlEncode;

/**
 UrlDecode解码

 @return 解码后的字符串
 */
- (NSString*)urlDecode;

#pragma mark - md5
/**
 字符串md5加密

 @return 加密后的字符串
 */
- (NSString *)md5String;

#pragma mark - DES+base64
/**
 字符串DES加密

 @param key 密钥
 @return 加密后的字符串
 */
- (NSString*) decryptDESWithKey:(NSString*)key;

/**
 字符串DES解密

 @param key 密钥
 @return 加密后的字符串
 */
- (NSString *) encryptDESWithKey:(NSString *)key;

#pragma mark - base64

/**
 对数据进行Base64加密

 @param data 需要加密的数据
 @return 加密后的字符串
 */
+ (NSString *)encodeBase64:(NSData *)data;

/**
 对字符串进行Base64加密

 @return 加密后的字符串
 */
- (NSString *)encodeBase64String;

/**
 对字符串进行Base64解密

 @param string 加密后的字符串
 @return 解密后的字符串
 */
+ (NSData *)decodeBase64:(NSString *)string;

/**
 对字符串进行Base64解密

 @return 解密后的字符串
 */
- (NSString *)decodeBase64String;

#pragma mark - sha1
/**
 Sha1加密
 
 @return 加密后的字符串
 */
- (NSString *)encodeSHA1;

#pragma mark - AES

/**
 AES256加密

 @param key 密钥
 @param vi 盐
 @return 加密后的字符串
 */
- (NSData *)encryptAES256WithKey:(NSString *)key
                              vi:(NSString *)vi;
/**
 AES256解密

 @param key 密钥
 @param vi 盐
 @return 加密后的字符串
 */
- (NSData *)decryptAES256WithKey:(NSString *)key
                              vi:(NSString *)vi;

#pragma mark - unit
/**
 将金额转换成带单位“万”、“百万”等的字符串

 @return 转换后的字符串
 */
- (NSString *)unitString;

/**
 将金额除于传入的除数（返回值保留两位小数）

 @param devisor 除数
 @return 结果
 */
- (NSString *)unitStringWithDevisor:(NSString *)devisor;


/**
 字典转json字符串

 @param dic 字典
 @return json字符串
 */
+ (NSString*)jsonStringFromDictionary:(NSDictionary *)dic;

@end
