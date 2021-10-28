//
//  ViewController.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/11.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

#define WZBCELLID @"WZBCELLID"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *wzbTableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *vcArr;
@end

@implementation ViewController

- (void)initDataArr {
    self.dataArr = @[@"TestVC",@"SVProgerssHUD使用",@"libPhoneNumber-iOS",@"UIKitVC",@"NSTimer"];
    self.vcArr = @[@"TestVC",@"SVProgressHUDVC",@"PhoneNumberVC",@"UIKitVC",@"NSTimerVC"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataArr];
    
    self.wzbTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.wzbTableView.delegate = self;
    self.wzbTableView.dataSource = self;
    [self.wzbTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WZBCELLID];
    [self.view addSubview:self.wzbTableView];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath row : %ld",(long)indexPath.row);
    NSString *title = self.dataArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WZBCELLID forIndexPath:indexPath];
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor blueColor];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.vcArr[indexPath.row];
    Class cls = NSClassFromString(name);
    UIViewController  *vc = [[cls alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
