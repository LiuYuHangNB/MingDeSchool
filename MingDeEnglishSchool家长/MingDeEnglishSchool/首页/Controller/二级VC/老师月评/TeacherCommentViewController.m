//
//  TeacherCommentViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/18.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "TeacherCommentViewController.h"
#import "BaseHeader.h"
#import "TeacherCommentTableViewCell.h"
#import "SubmitEvaluationViewController.h"
static NSString * const kCell = @"TeacherCommentTableViewCell";
@interface TeacherCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TeacherCommentViewController
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [SVProgressHUD showWithStatus:@"加载中..."];
    self.title = @"老师月评";
    [self initTableView];
    
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGTH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:kCell bundle:nil] forCellReuseIdentifier:kCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TeacherCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    cell.selectionStyle = 0;
    cell.clickBlock = ^ {
    
        NSLog(@"row-%ld",indexPath.row);
        SubmitEvaluationViewController *sub = [SubmitEvaluationViewController new];
        [self.navigationController pushViewController:sub animated:YES];
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [SVProgressHUD dismiss];
    
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
