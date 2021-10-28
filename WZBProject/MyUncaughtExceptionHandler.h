//
//  MyUncaughtExceptionHandler.h
//  WZBProject
//
//  Created by zhibin wang on 2020/3/6.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyUncaughtExceptionHandler : NSObject
+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;
+ (void)TakeException:(NSException *) exception;
@end

NS_ASSUME_NONNULL_END
