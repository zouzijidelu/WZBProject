//
//  HSArrowMenuItem.h
//  Arm
//
//  Created by Michael Wu on 2019/7/3.
//  Copyright © 2019 iTalkBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSArrowMenuItemStyle,HSArrowMenuItem;

@protocol HSArrowMenuItemDelegate <NSObject>

- (void)arrowMenuItem:(HSArrowMenuItem *)item didClickAtIndex:(NSInteger)index;

@end

@interface HSArrowMenuItem : UIView

@property (nonatomic, strong) HSArrowMenuItemStyle *style;

- (instancetype)initWithItemStyle:(HSArrowMenuItemStyle *)style
                         delegate:(id<HSArrowMenuItemDelegate>)delegate
                            index:(NSInteger)index
                     cornerRadius:(CGFloat)cornerRadius
                       isNeedLine:(BOOL)isNeedLine;

- (NSString *)getItemTitle;
@end
