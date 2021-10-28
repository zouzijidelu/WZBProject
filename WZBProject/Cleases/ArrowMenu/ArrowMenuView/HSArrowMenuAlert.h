//
//  HSArrowMenuAlert.h
//  Arm
//
//  Created by Michael Wu on 2019/7/3.
//  Copyright © 2019 iTalkBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSArrowMenuItemStyle.h"
#import "HSArrowMenuItem.h"
#import "HSArrowMenuAlertStyle.h"

typedef NS_ENUM(NSUInteger, HSArrowMenuViewDirection) {
    HSArrowMenuViewDirectionLeftTop ,
    HSArrowMenuViewDirectionCenterTop,
    HSArrowMenuViewDirectionRightTop,
    
    HSArrowMenuViewDirectionLeftBottom ,
    HSArrowMenuViewDirectionCenterBottom,
    HSArrowMenuViewDirectionRightBottom,
    
};

typedef void(^HSArrowMenuAlertItemClickBlock)(HSArrowMenuItem *item, NSInteger index);
typedef void(^HSArrowMenuAlertCancelBlock)(void);


@interface HSArrowMenuAlert : UIView

@property (nonatomic, assign, readonly) BOOL isAppear;

+ (instancetype)showToast:(HSArrowMenuAlertStyle *)style
                    items:(NSArray<HSArrowMenuItemStyle *>*)items
                    point:(CGPoint)point
                direction:(HSArrowMenuViewDirection)direction
                superView:(UIView *)superView
                   cancel:(HSArrowMenuAlertCancelBlock)cancelClosure
                itemClick:(HSArrowMenuAlertItemClickBlock)clickClosure;

- (instancetype)initWithStyle:(HSArrowMenuAlertStyle *)style
                        items:(NSArray<HSArrowMenuItemStyle *>*)items
                        point:(CGPoint)point
                    direction:(HSArrowMenuViewDirection)direction
                    superView:(UIView *)superView
                       cancel:(HSArrowMenuAlertCancelBlock)cancelClosure
                    itemClick:(HSArrowMenuAlertItemClickBlock)clickClosure;

- (void)show;



@end
