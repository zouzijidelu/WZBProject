//
//  BZSingleton.m
//  WZBProject
//
//  Created by zhibin wang on 2020/11/19.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "BZSingleton.h"

@implementation BZSingleton
+ (instancetype)share {
    static BZSingleton *instance = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BZSingleton alloc] init];
    });
    return instance;
}

- (void)initDataBase {
    NSLog(@"initDataBase");
}
@end
