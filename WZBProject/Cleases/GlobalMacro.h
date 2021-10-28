//
//  GlobalMacro.h
//  WZBProject
//
//  Created by zhibin wang on 2020/2/25.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#ifndef GlobalMacro_h
#define GlobalMacro_h

// 常规控件----------------------------------------------------------------------------------
#define ScreenHeight        ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth         ([UIScreen mainScreen].bounds.size.width)
// 像素密度
#define DEFAULT_DENSITY 2
// 以iphone6为基准,如果以其他尺寸为基准的话,请修改下面的750和1334为对应尺寸即可.
#define kBase_Width  (750 / DEFAULT_DENSITY)
#define kBase_Height (1334 / DEFAULT_DENSITY)

#define kScaleSize(num) [FCCommon getScaleSize:num]

#pragma mark - 全局颜色
#define Global_RGBHex(rgbValue) [FCCommon colorWithHexString:rgbValue]
#define Global_RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#endif /* GlobalMacro_h */
