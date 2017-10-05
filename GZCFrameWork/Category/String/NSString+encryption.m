//
//  NSString+md5.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/21.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "NSString+encryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
//#import "GTMBase64/GTMBase64.h"
#import <UIKit/UIKit.h>


@implementation NSString(encryption)

#pragma mark - URL
- (NSString*)urlEncode
{
    NSString* escapedUrlString;
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue]>9) {
    escapedUrlString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
    //    }else{
    //        escapedUrlString= (NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)str, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    //    }
    return escapedUrlString;
}

- (NSString*)urlDecode
{
    return [self stringByRemovingPercentEncoding];
    //    return [str stringByReplacingPercentEscapesUsingEncoding:encode];
}

#pragma mark - md5
- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", bytes[i]];
    return result;
}


#pragma mark - DES
-(NSString*) decryptDESWithKey:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [NSString decodeBase64:self];
//    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

-(NSString *) encryptDESWithKey:(NSString *)key
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [NSString encodeBase64:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}


#pragma mark - base64
+(NSString *)encodeBase64:(NSData *)data{
    NSString* encodeResult = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}

-(NSString *)encodeBase64String{
    NSData* originData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}

+(NSData *)decodeBase64:(NSString *)string{
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return decodeData;
}

-(NSString *)decodeBase64String{
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    return decodeStr;
}

#pragma mark - sha1
- (NSString *)encodeSHA1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

#pragma mark - AES
- (NSData *)encryptAES256WithKey:(NSString *)key
                              vi:(NSString *)vi{//加密
    char keyPtr[kCCKeySizeAES256+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    char ivPtr[kCCKeySizeAES256+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [vi getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSUInteger dataLength = [data length];
    int diff = kCCKeySizeAES256 - (dataLength % kCCKeySizeAES256);
    char dataPtr[kCCKeySizeAES256];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    size_t bufferSize = kCCKeySizeAES256 + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          0x0000, //No padding
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}


- (NSData *)decryptAES256WithKey:(NSString *)key
                              vi:(NSString *)vi{//解密
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

-(NSString *)unitString{
    NSString *resultStr = nil;
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSString *devisor;
    NSString *resultUnit = @"";
    CGFloat nfloat = [self floatValue];
    //0～5位数不变，6～8位数转换为**万，9-12位数转换为**亿，12位数以上转化为**万亿
//    if (nfloat/10000<1) {
//        devisor = @"1";
//        resultUnit = @"";
//    }else
    if(nfloat/100000000<1){
        devisor = @"10000";
        resultUnit = @"万";
    }else
    if(nfloat/1000000000000<1){
        devisor = @"100000000";
        resultUnit = @"亿";
    }else{
        devisor = @"1000000000000";
        resultUnit = @"万亿";
    }
    NSDecimalNumber *divisorNumber = [NSDecimalNumber decimalNumberWithString:devisor];
    NSDecimalNumber *resultDec = [decNumber decimalNumberByDividingBy:divisorNumber];
    //直接输出结果
    //resultStr = [NSString stringWithFormat:@"%@%@",resultStr,resultUnit];
    //这里保留两位小数，并去除多余的0
    NSString *tempStr = [NSString stringWithFormat:@"%.2f",[resultDec floatValue]];
    resultStr = [NSString stringWithFormat:@"%@%@",@([tempStr floatValue]),resultUnit];
    return resultStr;
}

-(NSString *)unitStringWithDevisor:(NSString *)devisor{
    NSString *resultStr = nil;
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *divisorNumber = [NSDecimalNumber decimalNumberWithString:devisor];
    NSDecimalNumber *resultDec = [decNumber decimalNumberByDividingBy:divisorNumber];
    resultStr =  [NSString stringWithFormat:@"%.2f",[resultDec floatValue]];;
    return resultStr;
}

+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
