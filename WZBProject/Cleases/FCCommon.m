//
//  FCCommon.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/25.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "FCCommon.h"

@implementation FCCommon
/**
 按屏幕比例缩放宽高
 
 @param size 基准大小
 @return 缩放大小
 */
+ (CGFloat)getScaleSize:(CGFloat)size {
    
    CGFloat scaleWidth = ScreenWidth / kBase_Width;
    CGFloat scaleheight = ScreenHeight / kBase_Height;
    CGFloat scale = scaleWidth > scaleheight ? scaleheight : scaleWidth;
    size = size * scale;
    
    return size / DEFAULT_DENSITY;
}

/**
 十六进制的颜色转换为UIColor

 @param color 16进制颜色字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
