//
//  SignInViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/3.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "SignInViewController.h"
#import "BaseHeader.h"
@interface SignInViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *selectTableView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *button;

@end

@implementation SignInViewController
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"].mutableCopy;
    [self initTableView];

    [self initSelectTableView];
    [self initButton];
}
#pragma mark - 创建选择月份的Button
- (void)initButton {
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(0, 64, 60, 40);
    [_button setTitle:@"选择" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 选择月份的点击方法
- (void)select:(UIButton *)button {
   
   [UIView animateWithDuration:0.1f delay:0.1f options:UIViewAnimationOptionLayoutSubviews animations:^{
       
       _selectTableView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);


   } completion:^(BOOL finished) {
       
       [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
           _selectTableView.transform = CGAffineTransformIdentity;
       } completion:nil];
       
   }];
}
#pragma mark - 初始化月份列表
- (void)initSelectTableView {
    
    _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 90, 200) style:UITableViewStylePlain];
    _selectTableView.delegate = self;
    _selectTableView.dataSource = self;
    _selectTableView.transform = CGAffineTransformMakeScale(0.f, 0.f);
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.selectTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.selectTableView.separatorInset = UIEdgeInsetsZero;
    }
    //    2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.selectTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.selectTableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self.view addSubview:_selectTableView];
    [_selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SWIDTH, SHEIGTH - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //    2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"caaa"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _selectTableView) {
        
        return _dataArray.count;

    }
    if (tableView == _tableView) {
        
        return 10;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _selectTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = _dataArray[indexPath.row];
        cell.selectionStyle = 0;
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    }
    
    if (tableView == _tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"caaa"];
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        cell.selectionStyle = 0;
        cell.textLabel.text = @"小明未签到";
        return cell;
    }
    
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _selectTableView) {
        [_button setTitle:_dataArray[indexPath.row] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.1f delay:0.1f options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            _selectTableView.transform = CGAffineTransformMakeScale(0.7f, 0.7f);
            
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _selectTableView.transform = CGAffineTransformMakeScale(.0f, .0f);
            } completion:nil];
            
        }];
        
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
