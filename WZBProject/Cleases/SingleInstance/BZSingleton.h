//
//  BZSingleton.h
//  WZBProject
//
//  Created by zhibin wang on 2020/11/19.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BZSingleton : NSObject
+ (instancetype)share
- (void)initDataBase;
@end

NS_ASSUME_NONNULL_END
