//
//  DDLogFileManagerDefault.m
//  FamilyCloud
//
//  Created by 阿涛 on 2019/11/20.
//  Copyright © 2019年 iTalkBB. All rights reserved.
//

#import "BaseLogFileManager.h"

@implementation BaseLogFileManager
-(NSString *)newLogFileName {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *timeStamp = [self getTimestamp];
    
    return [NSString stringWithFormat:@"%@%@.log",appName, timeStamp];
}

-(BOOL)isLogFile:(NSString *)fileName {
    return NO;
}

-(NSString *)getTimestamp {
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYY.MM.dd-HH-mm-ss"];
    });
    
    return [dateFormatter stringFromDate:NSDate.date];
}
@end
