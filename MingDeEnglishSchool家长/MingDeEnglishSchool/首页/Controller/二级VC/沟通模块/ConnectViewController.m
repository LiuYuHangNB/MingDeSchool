//
//  ConnectViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/18.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "ConnectViewController.h"
#import "BaseHeader.h"
#import "EaseMessageViewController.h"
#import "ChatViewController.h"
@interface ConnectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"老师列表";
    [self initTableView];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"小明";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatViewController *chaVC=[[ChatViewController alloc]initWithConversationChatter:@"sbTeacher" conversationType:eConversationTypeChat];
    chaVC.imageName = @"daxiang";
    chaVC.title = @"sbTeacher";
    chaVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chaVC animated:YES];
    
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
