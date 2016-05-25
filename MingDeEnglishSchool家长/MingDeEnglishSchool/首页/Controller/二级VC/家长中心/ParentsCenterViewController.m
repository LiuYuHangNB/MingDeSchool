//
//  ParentsCenterViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/18.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "ParentsCenterViewController.h"
#import "BaseHeader.h"
#import "WeekCommentsViewController.h"
#import "SignInViewController.h"
#import "PhotoWallViewController.h"
#import "RecordsOfHonorViewController.h"
#import "MedicalInformationViewController.h"
static NSString *const kCell = @"teacherCenterCell";

@interface ParentsCenterViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ParentsCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家长中心";
    [self initData];
    [self initHeadView];
    [self initTableView];
}
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)initHeadView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 210 * HEIGTH)];
    headView.backgroundColor = COLOR;
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    back.frame = CGRectMake(20, 28, 30, 30);
    [back addTarget:self action:@selector(handleBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:back];
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    imageView.center = CGPointMake(SWIDTH / 2, 85 *HEIGTH);
    imageView.image = [UIImage imageNamed:@"1"];
    imageView.layer.cornerRadius = 60;
    imageView.layer.masksToBounds = YES;
    [headView addSubview:imageView];
    // label
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    labelOne.center = CGPointMake(SWIDTH / 2, 150 * HEIGTH);
    labelOne.text = @"家长";
    labelOne.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:labelOne];
    //
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    labelTwo.center = CGPointMake(SWIDTH / 2, 180 *HEIGTH);
    labelTwo.text = @"今天是您第几次登录";
    labelTwo.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:labelTwo];
    
    [self.view addSubview:headView];
}
- (void)handleBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据
- (void) initData {
    
    self.dataArray = @[@"周评记录", @"签到记录",@"照片墙", @"荣誉记录", @"医务信息"].mutableCopy;
   
}

#pragma mark - tableView 
- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 210 * HEIGTH, SWIDTH, SHEIGTH - 200 * HEIGTH) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
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
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.text = _dataArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeekCommentsViewController *weekComment = [WeekCommentsViewController new];
    weekComment.title = _dataArray[indexPath.row];
    SignInViewController *signIn = [SignInViewController new];
    signIn.title = _dataArray[indexPath.row];
    PhotoWallViewController *photoWall = [PhotoWallViewController new];
    photoWall.title = _dataArray[indexPath.row];
    RecordsOfHonorViewController *records = [RecordsOfHonorViewController new];
    records.title = _dataArray[indexPath.row];
    MedicalInformationViewController *medical = [MedicalInformationViewController new];
    medical.title = _dataArray[indexPath.row];
    switch (indexPath.row) {

        case 0:
            [self.navigationController pushViewController:weekComment animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:signIn animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:photoWall animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:records animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:medical animated:YES];
            break;

        default:
            break;
    }
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
