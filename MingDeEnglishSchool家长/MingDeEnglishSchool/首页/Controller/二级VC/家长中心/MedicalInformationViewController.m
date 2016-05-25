//
//  MedicalInformationViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/3.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "MedicalInformationViewController.h"
#import "BaseHeader.h"
#import "MedicalTableViewCell.h"
static NSString * const kCell = @"Cell";
@interface MedicalInformationViewController ()

@end

@implementation MedicalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //    2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"MedicalTableViewCell" bundle:nil] forCellReuseIdentifier:kCell];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MedicalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.selectionStyle = 0;
    
    return cell;
    
}
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
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
