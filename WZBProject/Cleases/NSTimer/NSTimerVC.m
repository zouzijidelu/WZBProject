//
//  NSTimerVC.m
//  WZBProject
//
//  Created by zhibin wang on 2020/3/15.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "NSTimerVC.h"

@interface NSTimerVC (){
    NSInteger interval;
    NSInteger remainTime;
}
@property (nonatomic, strong) NSTimer *testTimer2;
@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTaskIdentifier;
@property (nonatomic, strong) NSMutableArray *bgTaskArr;
@end

@implementation NSTimerVC
// NSTimer有8种创建方式，但是总的说起来就三种timerWithTimeInterval、
//scheduledTimerWithTimeInterval和
//initWithFireDate，但是又细分起来就两种，一种是需要手动加入NSRunLoop，一种是自动加入NSRunLoop中。NSTimer的八种方法如下：

//通过timerWithTimeInterval和initWithFireDate方法创建出来的定时器，都需要手动加入到RunLoop中才会执行，否则不会执行

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActive) name:UIApplicationWillResignActiveNotification object:nil];
    
}

- (void)beginBackground {
    //开启后台任务
    UIApplication *app = [UIApplication sharedApplication];
    self.bgTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
    }];
}

// 点击home键就会调用 比endterbackground早
- (void)resignActive {
    FCLogDebug(@"NSTimerVC ApplicationWillResignActive");
//    [self invalidateTimer2];
}

- (void)didEnterBackground {
    FCLogDebug(@"NSTimerVC didEnterBackground");
    [self beginBackground];
}

- (void)addTestTimer2 {
    self.testTimer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self->interval++;
        FCLogDebug(@"interval -- %ld",(long)self->interval);
        UIApplication *app = [UIApplication sharedApplication];
        if (self->remainTime) {
            
        }
        if (app.backgroundTimeRemaining <= 3) {
            self->remainTime++;
            self.bgTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
                NSLog(@"Starting background task with %f seconds remaining", app.backgroundTimeRemaining);
                if (self.bgTaskIdentifier != UIBackgroundTaskInvalid) {
                    [app endBackgroundTask:self.bgTaskIdentifier];
                    self.bgTaskIdentifier = UIBackgroundTaskInvalid;
                    self->remainTime = 0;
                }
            }];
        }
    }];
}

- (IBAction)addTimer2:(id)sender {
    [self addTestTimer2];
}

- (void)timer2OnTimer {
    NSLog(@"addTimer2 start");
}
- (IBAction)invalidate2:(id)sender {
    [self invalidateTimer2];
}

- (void)invalidateTimer2 {
    interval = 0;
    if (self.testTimer2.isValid) {
        [self.testTimer2 invalidate];
        self.testTimer2 = nil;
    }
}

#pragma mark lazy load
- (NSMutableArray *)bgTaskArr {
    if (!_bgTaskArr) {
        _bgTaskArr = [NSMutableArray new];
    }
    return _bgTaskArr;
}

@end
