//
//  HLULogFormatter.h
//  FamilyCloud
//
//  Created by 阿涛 on 2019/10/29.
//  Copyright © 2019年 iTalkBB. All rights reserved.
//

#import "DDContextFilterLogFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLULogFormatter : DDContextWhitelistFilterLogFormatter
/**
 这个类继承于 DDContextWhitelistFilterLogFormatter
 1. 利用加白名单实现分文件输出
 2. 重载formatLogMessage:方法，实现输出内容格式化
 */@end

NS_ASSUME_NONNULL_END
