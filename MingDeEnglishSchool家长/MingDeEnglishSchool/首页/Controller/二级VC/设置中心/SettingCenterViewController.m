//
//  SettingCenterViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/18.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "SettingCenterViewController.h"
#import "BaseHeader.h"
#import "PushTableViewCell.h"
#import "UpdateTableViewCell.h"
static NSString *kPushCell = @"PushTableViewCell";
static NSString *kUpdateCell = @"UpdateTableViewCell";

@interface SettingCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingCenterViewController
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNaviBar];
    [self initHeadImageView];
    [self initTableView];
}
- (void)initNaviBar {
    
    self.navigationController.navigationBar.barTintColor = COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"设置中心";
}
- (void)initHeadImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, 180 * HEIGTH)];
    imageView.image = [UIImage imageNamed:@"p"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 180 * HEIGTH, SWIDTH, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"版本号:1.0";
    [self.view addSubview:label];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 84 + 180 * HEIGTH, SWIDTH, 80) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setScrollEnabled:NO];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //    2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PushTableViewCell" bundle:nil] forCellReuseIdentifier:kPushCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UpdateTableViewCell" bundle:nil] forCellReuseIdentifier:kUpdateCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
    
        PushTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:kPushCell forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
        cell.SwitchBlock = ^(UISwitch *swi){
            
            if (swi.isOn) {
                
                NSLog(@"on");
                
            }else {
                
                NSLog(@"off");
            }
            
        };
        
        return cell;
        
    }
    else {
        
        UpdateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUpdateCell forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",@"934255701"];
        [self Postpath:url];
    }
    
}

-(void)Postpath:(NSString *)path
{
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
        [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
    }];
    
}

-(void)receiveData:(id)sender
{
    NSLog(@"receiveData=%@",sender);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if (![app_Version isEqualToString:[sender objectForKey:@"version"]]) {

        [[UIAlertTool new] showAlertView:self title:@"提示" message:@"版本有更新" cancelButtonTitle:@"不更新" otherButtonTitle:@"更新" confirm:^{
             NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/tian-mei-yi-dong-kao-qin/id934255701?mt=8"];
             
            [[UIApplication sharedApplication]openURL:url];
            
        } cancle:^{
            
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
