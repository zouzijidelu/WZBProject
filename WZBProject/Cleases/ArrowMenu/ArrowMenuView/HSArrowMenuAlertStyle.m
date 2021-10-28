//
//  HSArrowMenuAlertStyle.m
//  Arm
//
//  Created by Michael Wu on 2019/7/3.
//  Copyright © 2019 iTalkBB. All rights reserved.
//

#import "HSArrowMenuAlertStyle.h"

@implementation HSArrowMenuAlertStyle

- (instancetype)init {
    if (self = [super init]) {
        _backgroundColor = [UIColor clearColor];
        _showSeparateLine = NO;
        _lineColor = [UIColor lightTextColor];
        
        _triangleLeftMargion = 10.f;
        _triangleSize = CGSizeMake(18, 10);
        _cornerRadius = 5.f;
        _enableShadow = YES;
        _isNeedLine = YES;
    }
    return self;
}

@end
