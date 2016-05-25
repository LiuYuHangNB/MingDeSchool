//
//  PerfectInfoViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/20.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "PerfectInfoViewController.h"
#import "StudentInfoTableViewCell.h"
#import "StudentAllergyableViewCell.h"
#import "BaseHeader.h"
NSString * const kInfoCell = @"StudentInfoTableViewCell";
NSString * const kAllerCell = @"StudentAllergyableViewCell";

@interface PerfectInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) UIView *headView;
@end

@implementation PerfectInfoViewController
- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _sectionArray = @[@"学生",@"个人简介",@"家长"].mutableCopy;
    [self initHeadView];
    [self initTableView];
}
- (void)initHeadView {
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 160 * HEIGTH)];
    _headView.backgroundColor = COLOR;
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    imageView.center = CGPointMake(SWIDTH / 2, 70 *HEIGTH);
    imageView.image = [UIImage imageNamed:@"1"];
    imageView.layer.cornerRadius = 60;
    imageView.layer.masksToBounds = YES;
    [_headView addSubview:imageView];
    // label
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 25)];
    labelOne.center = CGPointMake(SWIDTH / 2, 135 * HEIGTH);
    labelOne.text = @"事实上事实上事实上";
    labelOne.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:labelOne];
    
    
}

#pragma mark - tableView
- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = _headView;
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //    2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"StudentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:kInfoCell];
    [_tableView registerNib:[UINib nibWithNibName:@"StudentAllergyableViewCell" bundle:nil] forCellReuseIdentifier:kAllerCell];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        
        return 1;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        StudentInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kInfoCell];
        cell.selectionStyle = 0;
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    }else if (indexPath.section == 1) {
        
        StudentAllergyableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAllerCell];
        cell.selectionStyle = 0;
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        cell.textView.delegate = self;
        cell.tag = 100;
        return cell;
    }
    
    StudentInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kInfoCell];
    cell.selectionStyle = 0;
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.textField.delegate = self;
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 40)];
    sectionLabel.text = _sectionArray[section];
    sectionLabel.backgroundColor = [UIColor colorWithWhite:0.902 alpha:0.602];
    return sectionLabel;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 50;
    }else if (indexPath.section == 1) {
        
        return 150;
    }
    
    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    StudentAllergyableViewCell *cell = (StudentAllergyableViewCell *)[_tableView viewWithTag:100];
    cell.textView.text = @"";
    _tableView.contentOffset = CGPointMake(0, 300);
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    _tableView.contentOffset = CGPointMake(0, 400);

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
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
