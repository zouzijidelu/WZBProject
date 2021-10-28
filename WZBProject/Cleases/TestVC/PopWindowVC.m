//
//  PopWindowVC.m
//  WZBProject
//
//  Created by zhibin wang on 2020/2/25.
//  Copyright © 2020 iTalkBB. All rights reserved.
//

#import "PopWindowVC.h"
#import <Masonry/Masonry.h>

#define CELLID @"TESTCELLID"
@interface PopWindowVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *memberTableView;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation PopWindowVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        self.dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
//    self.dataArr = @[@"test",@"test",@"test",@"test"];
}

- (void)initView {
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.8;
    [self.memberTableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:CELLID];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.memberTableView];
    [self.view addSubview:self.cancelButton];
    [self setFrame];
}

- (void)setFrame {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(460);
    }];
    [self.memberTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-90);
        make.height.mas_equalTo(320);
    }];
    [self .cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.offset(-30);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(ScreenWidth - 44);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark tableview delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"test");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)cancelButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark lazyload

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 15;
    }
    return _contentView;
}

- (UITableView *)memberTableView {
    if (!_memberTableView) {
        _memberTableView = [[UITableView alloc] init];
        _memberTableView.delegate = self;
        _memberTableView.dataSource = self;
        _memberTableView.backgroundColor = [UIColor clearColor];
        _memberTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _memberTableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //_cancelButton.backgroundColor = [UIColor greenColor];
        _cancelButton.layer.cornerRadius = 22;
        _cancelButton.layer.borderColor = Global_RGBHex(@"#CCCCCC").CGColor;
        _cancelButton.layer.borderWidth = 1;
    }
    return _cancelButton;
}
@end
