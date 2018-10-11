//
//  NSString+LGEncrypt.h
//  LGLockerDemo
//
//  Created by 刘亚军 on 2018/10/10.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGEncrypt)
/**
 加密
 
 @param key 加密/解密时约定的key
 @param encryptStr 需要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)lg_encryptWithKey:(NSString *)key encryptStr:(NSString *)encryptStr;

/**
 加密
 
 @param encryptStr 需要加密的字符串
 @return 经过MD5加密后的字符串
 */
+ (NSString *)lg_md5EncryptStr:(NSString *)encryptStr;

/**
 解密
 
 @param key 加密/解密时约定的key
 @param decryptStr 需要解密的字符串
 @return 解密后的字符串
 */
+ (NSString *)lg_decryptWithKey:(NSString *)key decryptStr:(NSString *)decryptStr;

/** 字符串逆序 */
- (NSString *)lg_reverse;
@end
