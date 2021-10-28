//
//  UIKitVC.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/22.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "UIKitVC.h"
#import "TitleInCenterCell.h"

#define TitleInCenterCellStr @"TitleInCenterCell"

@interface UIKitVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *uiTableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *vcArr;
@end

@implementation UIKitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
}

- (void)initData {
    self.dataArr = @[@"UIGestureRecognizer"];
    self.vcArr = @[@"UIGestureRecognizerVC"];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.uiTableView];
    [self.uiTableView registerClass:NSClassFromString(TitleInCenterCellStr) forCellReuseIdentifier:TitleInCenterCellStr];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataArr[indexPath.row];
    //（1）dequeueReusableCellWithIdentifier（2）dequeueReusableCellWithIdentifier: forIndexPath:
    //方法1 需要自己判断是否为空 自己init cell 方法2 如果cell池中无可用 系统帮你创建 需要保证所要创建的cell类型已经注册
    TitleInCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleInCenterCellStr forIndexPath:indexPath];
    cell.titleStr = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.vcArr[indexPath.row];
    Class cls = NSClassFromString(name);
    UIViewController  *vc = [[cls alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)uiTableView {
    if (!_uiTableView) {
        _uiTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _uiTableView.delegate = self;
        _uiTableView.dataSource = self;
    }
    return _uiTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
