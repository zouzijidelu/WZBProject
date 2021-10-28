//
//  HLULogFormatter.m
//  FamilyCloud
//
//  Created by 阿涛 on 2019/10/29.
//  Copyright © 2019年 iTalkBB. All rights reserved.
//

#import "HLULogFormatter.h"

@implementation HLULogFormatter
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"Error";       break;
        case DDLogFlagWarning  : logLevel = @"Warning";     break;
        case DDLogFlagInfo     : logLevel = @"Info";        break;
        case DDLogFlagDebug    : logLevel = @"Debug";       break;
        case DDLogFlagVerbose  : logLevel = @"Verbose";     break;
        default                : logLevel = @"Default";     break;
    }
    
    NSDate *date = logMessage->_timestamp;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    NSDate *nowDate = [date dateByAddingTimeInterval:time];
    
    return [NSString stringWithFormat:@"%@ | %@ | %@ | %@ | %@", nowDate, logLevel, logMessage->_fileName, logMessage->_function, logMessage->_message];
}
@end
