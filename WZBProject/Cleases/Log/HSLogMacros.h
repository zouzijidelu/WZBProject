//
//  HSLogMacros.h
//  Arm
//
//  Created by Michael Wu on 2019/6/27.
//  Copyright © 2019 iTalkBB. All rights reserved.
//

#ifndef HSLogMacros_h
#define HSLogMacros_h

#import "FCLog.h"

#define HS_LOG_MACRO(flg, frmt, ...) \
[FCLog log:(flg) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt), ##__VA_ARGS__]

#define FCLogVerbose(frmt, ...) \
HS_LOG_MACRO(HSLogFlagVerbose, frmt, ##__VA_ARGS__)

#define FCLogDebug(frmt, ...) \
HS_LOG_MACRO(HSLogFlagDebug, frmt, ##__VA_ARGS__)

#define FCLogInfo(frmt, ...)\
HS_LOG_MACRO(HSLogFlagInfo, frmt, ##__VA_ARGS__)

#define FCLogWarn(frmt, ...)\
HS_LOG_MACRO(HSLogFlagWarning, frmt, ##__VA_ARGS__)

#define FCLogError(frmt, ...)\
HS_LOG_MACRO(HSLogFlagError, frmt, ##__VA_ARGS__)


#define LOG_HANDLER [HSLog logger]

#endif /* HSLogMacros_h */
