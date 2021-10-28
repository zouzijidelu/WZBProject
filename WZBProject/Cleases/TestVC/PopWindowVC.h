//
//  PopWindowVC.h
//  WZBProject
//
//  Created by zhibin wang on 2020/2/25.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopWindowVC : UIViewController

@property (nonatomic, strong) NSArray *dataArr;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
