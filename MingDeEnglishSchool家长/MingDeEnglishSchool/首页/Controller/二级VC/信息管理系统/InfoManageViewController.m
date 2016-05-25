//
//  InfoManageViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/18.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "InfoManageViewController.h"
#import "BaseHeader.h"
#import "WeekRecipeViewController.h"
#import "DynamicInforViewController.h"
#import "NoticeInforViewController.h"
#import "InfoManagerTableViewCell.h"
static NSString *const KCell = @"Cell";
@interface InfoManageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation InfoManageViewController

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initNaviBar];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //    2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"InfoManagerTableViewCell" bundle:nil] forCellReuseIdentifier:KCell];
    
}
#pragma mark --- NaviBar
- (void)initNaviBar {
    
    self.navigationController.navigationBar.barTintColor = COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"信息管理系统";
}
#pragma mark --- tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    cell.contentLabel.text = _dataArray[indexPath.row];
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.selectionStyle = 0;
    cell.accessoryType = 1;
    cell.imgView.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        WeekRecipeViewController *weekRecipe = [WeekRecipeViewController new];
        weekRecipe.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:weekRecipe animated:YES];
    }else if (indexPath.row == 0) {
        DynamicInforViewController *dy = [DynamicInforViewController new];
        dy.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:dy animated:YES];
    }else if (indexPath.row == 1) {
        
        NoticeInforViewController *notice = [NoticeInforViewController new];
        notice.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:notice animated:YES];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
#pragma mark - 数据
- (void) initData {
    
    self.dataArray = @[@"动态信息", @"公告信息", @"本周食谱",@"照片墙",@"荣誉榜"].mutableCopy;
    self.imagesArray = @[@"dongtai",@"gonggao",@"shipu",@"zhaopian",@"rongyu"].mutableCopy;
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
