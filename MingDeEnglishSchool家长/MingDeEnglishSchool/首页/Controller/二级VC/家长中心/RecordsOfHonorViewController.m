//
//  RecordsOfHonorViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/3.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "RecordsOfHonorViewController.h"
#import "RecordsOfHonorTableViewCell.h"
#import "BaseHeader.h"
static NSString * const kCell = @"Cell";
@interface RecordsOfHonorViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RecordsOfHonorViewController
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = 0;
    [_tableView registerNib:[UINib nibWithNibName:@"RecordsOfHonorTableViewCell" bundle:nil] forCellReuseIdentifier:kCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordsOfHonorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    cell.selectionStyle = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 155;
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
