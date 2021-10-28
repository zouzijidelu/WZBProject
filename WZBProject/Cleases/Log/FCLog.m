//
//  FCLog.m
//  FamilyCloud
//
//  Created by zhibin wang on 2019/10/12.
//  Copyright © 2019年 iTalkBB. All rights reserved.
//

#import "FCLog.h"
//#import "FCZipTool.h"
//#import "ZipArchive.h"
#import "DDFileLogger.h"
#import <CocoaLumberjack.h>

#ifdef DEBUG
#else
//static DDLogLevel ddLogLevel = DDLogLevelDebug;
#endif

//#ifdef DEBUG
//static DDLogLevel ddLogLevel = DDLogLevelVerbose;
//#else
//static DDLogLevel ddLogLevel = DDLogLevelDebug;
//#endif


@implementation FCLog

//
+ (void)log:(HSLogFlag)flag
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
     format:(NSString *)format, ... {
//DDLogInfo
    if (!(ddLogLevel & flag)) {
        return;
    }
    
    va_list args;
    
    if (format) {
        va_start(args, format);
        
        BOOL async = YES;
        if (flag & HSLogFlagError) {
            async = NO;
        }
        
        [DDLog log:async level:ddLogLevel flag:(DDLogFlag)flag context:0 file:file function:function line:line tag:nil format:format args:args]; // DDLog code logic.
        
//        if (flag & HSLogFlagWarning) {
//#ifndef DEBUG
//            NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
//            LOGHSIMetisReportLog(IMCustomEventName_AppWarnHigherLog, message, HSIMetisEventLevelWarn, nil);
//#endif
//        }
//
//        else if (flag & HSLogFlagError) {
//#ifndef DEBUG
//            NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
//            LOGHSIMetisReportLog(IMCustomEventName_AppWarnHigherLog, message, HSIMetisEventLevelError, nil);
//#endif
//        }
        
        va_end(args);
    }
}


@end
