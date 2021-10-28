//
//  FCCommon.h
//  WZBProject
//
//  Created by zhibin wang on 2020/2/25.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FCCommon : NSObject
/**
按屏幕比例缩放宽高

@param size 基准大小
@return 缩放大小
*/
+ (CGFloat)getScaleSize:(CGFloat)size;
/**
 十六进制的颜色转换为UIColor

 @param color 16进制颜色字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color;
@end

NS_ASSUME_NONNULL_END
