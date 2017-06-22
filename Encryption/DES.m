//
//  DES.m
//  NewDes
//
//  Created by 连喜 邓 on 12-12-23.
//  Copyright (c) 2012年 连喜 邓. All rights reserved.
//

#import "DES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "CommonFunc.h"

@implementation DES

+ (NSData*) EncryptToData:(NSString*) plainText byKey:(NSString*) key {
    const void *vplainText;
    size_t plainTextBufferSize;
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySizeDES,
                       vinitVec, //"init Vec", //iv,
                       vplainText, //"Your Name", //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *retData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    @try {
        vplainText = NULL;
        bufferPtr = NULL;
        vkey = NULL;
        vinitVec = NULL;
    }
    @catch (NSException *exception)  {
    }
    
    return retData;
}

+ (NSString*) DecryptFromData:(NSData*) encData byKey:(NSString*) key {
    const void *vplainText;
    size_t plainTextBufferSize;
    plainTextBufferSize = [encData length];
	vplainText = [encData bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    NSString *initVec = @"init Vec";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySizeDES,
                       vinitVec, //"init Vec", //iv,
                       vplainText, //"Your Name", //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSString *string = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes]
                                             encoding:NSUTF8StringEncoding];
    @try {
        vplainText = NULL;
        bufferPtr = NULL;
        vkey = NULL;
        vinitVec = NULL;
    }
    @catch (NSException *exception)  {
    }
    return string;
}

+ (NSString*) EncryptToBase64:(NSString*) plainText byKey:(NSString*) key {
    return [[DES EncryptToData:plainText byKey:key] base64Encoding];
}

+ (NSString*) DecryptFromBase64:(NSString*) base64EncText byKey:(NSString*) key {
    return [DES DecryptFromData:[CommonFunc dataWithBase64EncodedString:base64EncText] byKey:key];
}


@end
