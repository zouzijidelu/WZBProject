//
//  FCLog.h
//  FamilyCloud
//
//  Created by zhibin wang on 2019/10/12.
//  Copyright © 2019年 iTalkBB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, FCuploadType){
    FCuploadTypeNetworkAndRoute = 0,
    FCuploadTypeFeedback ,
    FCuploadTypeAllLog
};
/**
 Flags accompany each log. They are used together with levels to filter out logs.
 */
typedef NS_OPTIONS(NSUInteger, HSLogFlag){
    
    /**
     *  0...00001 DDLogFlagError
     */
    HSLogFlagError      = (1 << 0),
    
    /**
     *  0...00010 DDLogFlagWarning
     */
    HSLogFlagWarning    = (1 << 1),
    
    /**
     *  0...00100 DDLogFlagInfo
     */
    HSLogFlagInfo       = (1 << 2),
    
    /**
     *  0...01000 DDLogFlagDebug
     */
    HSLogFlagDebug      = (1 << 3),
    
    /**
     *  0...10000 DDLogFlagVerbose
     */
    HSLogFlagVerbose    = (1 << 4)
};

/**
 *  Log levels are used to filter out logs. Used together with flags.
 */
typedef NS_ENUM(NSUInteger, HSLogLevel){
    /**
     *  No logs
     */
    HSLogLevelOff       = 0,
    
    /**
     *  Error logs only
     */
    HSLogLevelError     = (HSLogFlagError),
    
    /**
     *  Error and warning logs
     */
    HSLogLevelWarning   = (HSLogLevelError   | HSLogFlagWarning),
    
    /**
     *  Error, warning and info logs
     */
    HSLogLevelInfo      = (HSLogLevelWarning | HSLogFlagInfo),
    
    /**
     *  Error, warning, info and debug logs
     */
    HSLogLevelDebug     = (HSLogLevelInfo    | HSLogFlagDebug),
    
    /**
     *  Error, warning, info, debug and verbose logs
     */
    HSLogLevelVerbose   = (HSLogLevelDebug   | HSLogFlagVerbose),
    
    /**
     *  All logs (1...11111)
     */
    HSLogLevelAll       = NSUIntegerMax
};


@interface FCLog : NSObject

@property (nonatomic, assign) FCuploadType type;

+ (void)log:(HSLogFlag)flag
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
     format:(NSString *)format, ...;

@end

NS_ASSUME_NONNULL_END
