# Encryption
DES,RSA加解密，base64格式字符串转换，字典排序的具体实现：

   具体实现了目前常用的加解密方法，非常简便。
   
   
   1，将类加入项目，加上头文件#import "DES.h" #import "RSA.h"
   
   2，直接调用，完毕！
   
   
   
   //Des加密
    NSString *secretDesString =[DES EncryptToBase64:TEST_KEY byKey:DES_KEY];
    NSLog(@"Des加密后为：%@",secretDesString);
    
    //Des解密
    NSString *secretGetString =[DES DecryptFromBase64:secretDesString byKey:DES_KEY];
    NSLog(@"Des解密后为：%@",secretGetString);
    
    //RSA公钥加密
    NSString *RSAreturnString = [RSA encryptString:arcString publicKey:RSA_PUBLIC_KEY];
    NSLog(@"RSA加密后为：%@",RSAreturnString);
    
    
    //将文本转换为base64格式字符串
    NSString *base64ReturnString = [CommonFunc base64StringFromText:TEST_KEY];
    NSLog(@"base64后为：%@",base64ReturnString);
    
    //将base64格式字符串转换为文本
    NSString *dBase64ReturnString = [CommonFunc textFromBase64String:base64ReturnString];
    NSLog(@"base64转字符串后为：%@",dBase64ReturnString);
    
    //字典排序，接口加解密中也是经常用到的
    NSDictionary *showDic =[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name",@"男",@"sex",@"学生",@"job", nil];
    NSString *getPaiXuString =[self getResultSignWithDic:showDic];
    NSLog(@"字典排序后合并的字符串为：%@",getPaiXuString);
    
    
    以上方法全来自dema，注意DES_KEY，RSA_PUBLIC_KEY根据自己需求设置。
