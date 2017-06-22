//
//  ViewController.m
//  Encryption
//
//  Created by 连喜 邓 on 2017/6/22.
//  Copyright © 2017年 连喜 邓. All rights reserved.
//

#import "ViewController.h"
#import "DES.h"
#import "RSA.h"
#import "CommonFunc.h"

#define  TEST_KEY             @"secretTest"
#define  DES_KEY              @"7E8E0AE61DF14DA9160A8E9041D9AFDB"
#define  RSA_PUBLIC_KEY       @"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwR8DbeVix7CO56Y8NUMPxFOSnuSMwFbptYGOXMrAszdgcDILsd0Zt1IgxtULRu+io3fbDLfotRHrRTl9jfQT5OQH8NuLbKlpKqKvpK6CtH8oOydrdUMf+wEnnLMmAJEZH3f/q6w4uWqOzjndN8HZTi2cdz8xkFY1IM3J3d8Yxdq0zmUmz4ZM98wpM9tjyb90K37fV88xP/JzDuyjzf60u9GSEUGfSmrHc6jIg2t4GU3gEDOvUfT3xP4opAQVDRXjHj4U5lSIn+ld6pTr825sUlIKtLSR8mQrDddjuL/It05Fw0l3bgC35Q6SuV2dzcu0YCURy5xd4LmPyHm4TeAdIQIDAQAB\n-----END PUBLIC KEY-----"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#pragma mark ===============================================
#pragma mark //Des加解密
#pragma mark ===============================================
    //Des加密
    NSString *secretDesString =[DES EncryptToBase64:TEST_KEY byKey:DES_KEY];
    NSLog(@"Des加密后为：%@",secretDesString);
    
    //Des解密
    NSString *secretGetString =[DES DecryptFromBase64:secretDesString byKey:DES_KEY];
    NSLog(@"Des解密后为：%@",secretGetString);
    
    
    
#pragma mark ===============================================
#pragma mark //RSA公钥加密
#pragma mark ===============================================
    NSMutableString * arcString = [[NSMutableString alloc] init];
    for (int i = 0; i < 16; i++) {
        int charOrNum = arc4random() % 2;
        // 输出字母还是数字
        if (charOrNum == 0) {
            [arcString appendFormat:@"%c",(char)('A' + (arc4random_uniform(26)))];
        } else if (charOrNum == 1) {
            
            [arcString appendFormat:@"%d",arc4random()%10];
        }
    }
    NSString *RSAreturnString = [RSA encryptString:arcString publicKey:RSA_PUBLIC_KEY];
    NSLog(@"RSA加密后为：%@",RSAreturnString);
    
    
    
#pragma mark ===============================================
#pragma mark base64格式字符串转换
#pragma mark ===============================================
    //将文本转换为base64格式字符串
    NSString *base64ReturnString = [CommonFunc base64StringFromText:TEST_KEY];
    NSLog(@"base64后为：%@",base64ReturnString);
    
    //将base64格式字符串转换为文本
    NSString *dBase64ReturnString = [CommonFunc textFromBase64String:base64ReturnString];
    NSLog(@"base64转字符串后为：%@",dBase64ReturnString);

    
    
#pragma mark ===============================================
#pragma mark 字典排序，接口加解密中也是经常用到的
#pragma mark ===============================================
    NSDictionary *showDic =[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name",@"男",@"sex",@"学生",@"job", nil];
    NSString *getPaiXuString =[self getResultSignWithDic:showDic];
    NSLog(@"字典排序后合并的字符串为：%@",getPaiXuString);
   
    
}

//字典排序
-(NSString *)getResultSignWithDic:(NSDictionary *)dictionary
{
    NSArray *keys =[dictionary allKeys];
    NSArray *sortedArray =[keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    NSMutableArray *returnArray =[[NSMutableArray alloc] init];
    for(__strong id obj in sortedArray)
    {
        obj =(NSString *)obj;
        [returnArray addObject:[obj stringByAppendingFormat:@"%@",[dictionary objectForKey:obj]]];
    }
    NSString *lastString =[returnArray componentsJoinedByString:@""];
    
    return lastString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
