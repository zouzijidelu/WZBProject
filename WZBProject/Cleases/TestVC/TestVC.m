//
//  TestVC.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/25.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "TestVC.h"
#import "PopWindowVC.h"

@interface TestVC ()


@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)popWindowClick:(id)sender {
    PopWindowVC *pVC = [[PopWindowVC alloc] init];
    pVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pVC animated:YES completion:nil];
}

@end
