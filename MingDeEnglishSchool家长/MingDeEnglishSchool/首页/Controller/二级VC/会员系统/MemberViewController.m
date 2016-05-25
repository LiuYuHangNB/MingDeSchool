//
//  MemberViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/18.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "MemberViewController.h"
#import "BaseHeader.h"
#import "LoginViewController.h"
#import "BindingPhoneViewController.h"
#import "PerfectInfoViewController.h"
#import "RetrievePasswordViewController.h"
static NSString *const KCell = @"cell";
@interface MemberViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initNaviBar];
    [self initTableView];
}

- (void)initNaviBar {
    
    self.navigationController.navigationBar.barTintColor = COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"会员系统";
}
#pragma mark - 数据
- (void) initData {
    self.dataArray = @[@"绑定手机号", @"资料完善",@"找回密码"].mutableCopy;
}
#pragma mark - TableView 
- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setScrollEnabled:NO];
    _tableView.tableFooterView = [UIView new];
    //1.调整(iOS7以上)表格分隔线边距
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    cell.selectionStyle = 0;
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.accessoryType = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BindingPhoneViewController *bindingPhone = [BindingPhoneViewController new];
    bindingPhone.hidesBottomBarWhenPushed = YES;
    bindingPhone.title = @"绑定手机号";
    PerfectInfoViewController *perfectInfo = [PerfectInfoViewController new];
    perfectInfo.hidesBottomBarWhenPushed = YES;
    perfectInfo.title = @"资料完善";
    RetrievePasswordViewController *retrieve = [RetrievePasswordViewController new];
    retrieve.hidesBottomBarWhenPushed = YES;
    retrieve.title = @"找回密码";
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:bindingPhone animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:perfectInfo animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:retrieve animated:YES];
            break;
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p"]];
    
    return imageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 180;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
