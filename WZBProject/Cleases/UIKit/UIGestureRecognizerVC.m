//
//  UIGestureRecognizerVC.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/23.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "UIGestureRecognizerVC.h"

@interface UIGestureRecognizerVC ()

@end

@implementation UIGestureRecognizerVC
// UIGestureRecognizer 是一个抽象类
/*
1.3.1 点击手势——UITapGestureRecognizer
1.3.2 捏合手势——UIPinchGestureRecognizer
1.3.3 旋转手势——UIRotationGestureRecognizer
1.3.4 滑动手势——UISwipeGestureRecognizer
1.3.5 长按手势——UILongPressGestureRecognizer
1.3.6 平移手势——UIPanGestureRecognzer
1.3.7 屏幕边缘平移手势——UIScreenEdgePanGestureRecognzer
 还可以自定义手势
*/
/*
这个SpringBoard其实是一个标准的应用程序，这个应用程序用来管理IOS的主屏幕，除此之外像启动WindowSever(窗口服务器),bootstrapping(引导应用程序),以及在启动时候系统的一些初始化设置都是由这个特定的应用程序负责的。它是我们IOS程序中，事件的第一个接受者。它只能接受少数的事件比如:按键(锁屏/静音等),触摸，加速，接近传感器等几种Event，随后使用macport转发给需要的App进程。
 */
//UIEvent
/*
 
 //事件没有子类型 iOS3.0之后可以用
 UIEventSubtypeNone                              = 0,
 
 //事件子类型晃动的设备 iOS3.0之后可以用
 UIEventSubtypeMotionShake                       = 1,
 
 //遥控的事件子类型 iOS4.0之后可以用
 UIEventSubtypeRemoteControlPlay                 = 100,//播放
 UIEventSubtypeRemoteControlPause                = 101,//暂停
 UIEventSubtypeRemoteControlStop                 = 102,//停止
 UIEventSubtypeRemoteControlTogglePlayPause      = 103,//播放和暂停之间切换【操作：播放或暂停状态下，按耳机线控中间按钮一下】
 UIEventSubtypeRemoteControlNextTrack            = 104,//下一曲【操作：按耳机线控中间按钮两下】
 UIEventSubtypeRemoteControlPreviousTrack        = 105,//上一曲【操作：按耳机线控中间按钮三下】
 UIEventSubtypeRemoteControlBeginSeekingBackward = 106,//快退开始【操作：按耳机线控中间按钮三下不要松开】
 UIEventSubtypeRemoteControlEndSeekingBackward   = 107,//快退结束【操作：按耳机线控中间按钮三下到了快退的位置松开】
 UIEventSubtypeRemoteControlBeginSeekingForward  = 108,//快进开始【操作：按耳机线控中间按钮两下不要松开】
 UIEventSubtypeRemoteControlEndSeekingForward    = 109,//快进结束【操作：按耳机线控中间按钮两下到了快进的位置松开】
 */
//UITouch事件处理
/*
 UIView不能接收事件的三种情况：
 1. 不允许交互 `userInteractionEnabled` = NO
 2. 透明度 `alpha` < 0.01
 3. 父视图或者子视图的 `hidden` = YES
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
}



@end
