//
//  DES.h
//  NewDes
//
//  Created by 连喜 邓 on 12-12-23.
//  Copyright (c) 2012年 连喜 邓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES : NSObject

+ (NSData*) EncryptToData:(NSString*) plainText byKey:(NSString*) key;

+ (NSString*) DecryptFromData:(NSData*) encData byKey:(NSString*) key;

+ (NSString*) EncryptToBase64:(NSString*) plainText byKey:(NSString*) key;

+ (NSString*) DecryptFromBase64:(NSString*) base64EncText byKey:(NSString*) key;



@end
