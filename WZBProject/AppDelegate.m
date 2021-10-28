//
//  AppDelegate.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/11.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "MyUncaughtExceptionHandler.h"
#import "ViewController.h"

//static NSString *encryptionKey = @"nha735n197nxn(N′568GGS%d~~9naei';45vhhafdjkv]32rpks;lg,];:vjo(&**&^)";

@interface AppDelegate ()
@property (nonatomic, strong) NSString *atString;
@property (nonatomic, strong) NSString *remindString;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupDDLog];
    [self initCrashLog];
    [self initWindow];
    return YES;
}

- (void)initCrashLog {
    NSLog(@"document-path:%@",NSHomeDirectory());
    #pragma mark -- 崩溃日志
    [MyUncaughtExceptionHandler setDefaultHandler];
    FCLogDebug(@"DidFinishLaunchingWithOptions");
        // 发送崩溃日志
    //    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    //    NSData *data = [NSData dataWithContentsOfFile:dataPath];
}

- (void)initWindow {
    ViewController *view = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)setupDDLog {
    
   // 启动日志
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.maximumFileSize = 1024 * 1024; //单个日志最大1M
    fileLogger.rollingFrequency = 7 * 60 * 60 * 24; // 保存周期2天
    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    [DDLog addLogger:fileLogger];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

#pragma mark -- 发送崩溃日志
- (void)sendExceptionLogWithData:(NSData *)data
{

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 5.0f;
//    //告诉AFN，支持接受 text/xml 的数据
//    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    NSString *urlString = @"后台地址";
//
//    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:@"file" fileName:@"Exception.txt" mimeType:@"txt"];
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//
//
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//
//
//    }];

}

- (NSString *)subString:(NSString *)originStr {
    if (![originStr containsString:@"#&#&"]) {
        self.atString = [NSString stringWithFormat:@"%@%@",self.atString,originStr];
        return self.atString;
    }
    NSRange startRange = [originStr rangeOfString:@"#&#&"];
    NSRange endRange = [originStr rangeOfString:@"&#&#"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [originStr substringWithRange:range];
    NSString *headStr = [originStr substringToIndex:startRange.location];
    self.atString = [NSString stringWithFormat:@"%@%@%@",self.atString,headStr,result];
    self.remindString = [originStr substringFromIndex:endRange.location + endRange.length];
    return [self subString:self.remindString];
}

- (NSString *)getBase64Message:(NSString *)originStr {
    NSRange startRange = [originStr rangeOfString:@"#*#*"];
    NSRange endRange = [originStr rangeOfString:@"*#*#"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [originStr substringWithRange:range];
    return result;
}

- (void)endecodeAndeDecode {
    NSString *str1 = @"#&#&1234567&#&# 哈道简欧风景OADNF拉时间段拉拉裤就发了卡加斯快递费辣妈代理费麻辣面发了吗反蒙面法马水立方啊ljlasjflasjdflkasjdkflajsdklfajsdlfkasldfjlaksdjflkasjdflkasjdflkasjdfklajsdfklajsdklfaskdljfklasdjflkasdjfklasdjflkasdjfklasdjfklasdjfklsadjfklasdjflkasdkflasdjfla";
    NSString *str2 = @"#&#&1234567&#&# 哈道简欧风景";
                    //IyYjJjEyMzQ1NjcmIyYjIOWTiOmBk+eugOasp+mjjuaZrw==
    NSLog(@"md5: %@",[self md5EncryptWithString:str1]);
    NSLog(@"base64: %@",[self base64EncodeString:str1]);
    NSLog(@"16进制: %@",[self hexStringFromString:str1]);
    
    NSString *strToBase64Str = [self base64EncodeString:str2];
    NSString *base64StrToStr = [self base64DecodeString:strToBase64Str];
    NSLog(@"md5: %@",[self md5EncryptWithString:str2]);
    NSLog(@"base64: %@",strToBase64Str);
    NSLog(@"base64: %@",base64StrToStr);
    NSLog(@"16进制: %@",[self hexStringFromString:str2]);
}

- (NSString *)md5EncryptWithString:(NSString *)string{
    return [self md5:[NSString stringWithFormat:@"%@", string]];
}

- (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

#pragma mark -对一个字符串进行base64编码，并返回
-(NSString *)base64EncodeString:(NSString *)string{
    //1、先转换成二进制数据
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}
-(NSString *)base64DecodeString:(NSString *)string{
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:string options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//普通字符串转换为十六进制的。
 
- (NSString *)hexStringFromString:(NSString *)string{
NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
Byte *bytes = (Byte *)[myD bytes];
//下面是Byte 转换为16进制。
NSString *hexStr=@"";
for(int i=0;i<[myD length];i++)
 
{
NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
 
if([newHexStr length]==1)
 
hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
 
else
 
hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
}
return hexStr;
}


@end
