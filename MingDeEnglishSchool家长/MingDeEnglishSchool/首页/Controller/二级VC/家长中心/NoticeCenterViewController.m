//
//  NoticeCenterViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/3.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "NoticeCenterViewController.h"
#import "NoticeCenterTableViewCell.h"
#import "BaseHeader.h"
static NSString *const kCell = @"NoticeCell";
@interface NoticeCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NoticeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self initNavigationBar];
}
- (void)initNavigationBar {
    self.navigationController.navigationBar.barTintColor = COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"通知中心";
}
- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64 - 48) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"NoticeCenterTableViewCell" bundle:nil] forCellReuseIdentifier:kCell];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoticeCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 147;
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
