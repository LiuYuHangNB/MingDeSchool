//
//  HomeViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//
#import "HomeViewController.h"
#import "EaseMob.h"
#import "BaseHeader.h"
#import "HomeBtnsCollectionViewCell.h"
// 八个VC
#import "InfoManageViewController.h"
#import "ParentsCenterViewController.h"
#import "GrowUpViewController.h"
#import "SettingCenterViewController.h"
#import "TeacherCommentViewController.h"
#import "ConnectViewController.h"
#import "LoginViewController.h"
static NSString *const kCell = @"cellOne";
static NSString *const kCollectionCell = @"cellTwo";
static NSString *const Name = @"HomeBtnsCollectionViewCell";

//
static CGFloat const kDefaultPlaySoundInterval = 3.0f;
static NSString *kMessageType = @"MessageType";

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,EMCallManagerDelegate,IChatManagerDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *SDCycleScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation HomeViewController
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    [self unregisterNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#warning 把self注册为SDK的delegate
    [self registerNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];

    // 判断是否为第一次登录第一次登录弹出登录界面
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //取值
    NSString *result = [userDefault objectForKey:@"userName"];
    
    if (result.length != 0) {
        
        LoginViewController *login = [LoginViewController new];

//        [self presentViewController:login animated:YES completion:nil];
        [self addChildViewController:login];
        
    }

    [self initData];
    [self initNavigationBar];
    [self initImageView];
    [self initTableView];
    [self initCollectionView];

    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 99) {
//        if (buttonIndex != [alertView cancelButtonIndex]) {
//            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//            } onQueue:nil];
//        }
//    }
//    else if (alertView.tag == 100) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//    } else if (alertView.tag == 101) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//    }
//}

#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = (message.messageType != eMessageTypeChat) ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        switch (state) {
            case UIApplicationStateActive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateInactive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateBackground:
                [self showNotificationWithMessage:message];
                break;
            default:
                break;
        }
#endif
    }
}

-(void)didReceiveCmdMessage:(EMMessage *)message
{
    [self showHint:NSLocalizedString(@"receiveCmd", @"receive cmd message")];
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{

    NSLog(@"%@",[[message.messageBodies lastObject] text]);
    
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    if (options) {
        //发送本地推送
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        UIUserNotificationType types = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        UILocalNotification *notif = [[UILocalNotification alloc]init];
        NSDate *data=[NSDate date];
        data=[data dateByAddingTimeInterval:1];
        notif.fireDate=data;
        notif.timeZone=[NSTimeZone defaultTimeZone];
        //notif.applicationIconBadgeNumber=1;
        notif.alertBody= @"您有一条新消息";
        //notif.alertTitle=@"您有一条新消息";
        notif.soundName = UILocalNotificationDefaultSoundName;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
        [dic setObject:[[message.messageBodies lastObject] text] forKey:@"key1"];
        [dic setObject:[[message.messageBodies firstObject] text] forKey:@"key2"];
        notif.userInfo = dic;
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
    }
}

#pragma mark - part 0 - NaviBar 
- (void)initNavigationBar {
    
    self.navigationController.navigationBar.barTintColor = COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"明德外国语小学";
}
#pragma mark - 数据
- (void) initData {
    
    self.imagesArray = [NSMutableArray array];
    self.titlesArray = [NSMutableArray array];
    [AFNetworkTool getUrl:@"http://app.qdaily.com/app/homes/index/0.json" body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id resposeObject) {
        
        NSArray *array = resposeObject[@"response"][@"banners"][@"list"];
        for (NSDictionary *dic in array) {
            
            [self.imagesArray addObject:dic[@"image"]];
            [self.titlesArray addObject:dic[@"post"][@"title"]];
            
            
        }
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    self.dataArray = @[@"xinxi", @"jiazhang", @"chengzhang", @"shezhi", @"yuepin", @"goutong"].mutableCopy;
    self.labelArray = @[@"信息管理系统", @"家长中心", @"成长档案", @"设置中心", @"老师月评", @"沟通模块"].mutableCopy;
}
#pragma mark - part 1 - UIImageView
- (void)initImageView {
    
    
    self.SDCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, SWIDTH, 165 * HEIGTH) delegate:self placeholderImage:[UIImage imageNamed:@"p"]];
    self.SDCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.SDCycleScrollView.titlesGroup = _titlesArray;
    self.SDCycleScrollView.currentPageDotColor = [UIColor orangeColor];
        [self.view addSubview:self.SDCycleScrollView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        self.SDCycleScrollView.imageURLStringsGroup = _imagesArray;
    });
    
}
#pragma mark ——————————————————————轮播图的点击方法
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"---点击了第%ld张图片", (long)index + 1);
    
}

#pragma mark - part 2 - UITableView
- (void)initTableView {
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newButton.frame = CGRectMake(0 * WIDTH, 64 + 170 * HEIGTH, 100 * WIDTH, 20 * HEIGTH);
    [newButton setTitle:@"新闻公告" forState:UIControlStateNormal];
    newButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:newButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10 * WIDTH, 200 * HEIGTH + 64, SWIDTH - 20 * WIDTH, 100 * HEIGTH) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tableView.layer.cornerRadius = 8;
    self.tableView.scrollEnabled = NO;
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    //2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    
}
#pragma mark - 代理 TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCell];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"明德外语小学召开五年级家长会";
        cell.detailTextLabel.text = @"2016-3-14";
    }
    else {
        cell.textLabel.text = @"奉贤明德外语小学心里危机预警干预机制";
        cell.detailTextLabel.text = @"2016-3-12";

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50 * HEIGTH;
}

#pragma mark - part 3 - UICollectionView 
- (void)initCollectionView {
    
    UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
    flow.itemSize = CGSizeMake(SWIDTH / 3, (SHEIGTH - 113 - 320 * HEIGTH) / 2);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 310 * HEIGTH, SWIDTH, SHEIGTH - 113 - 320 * HEIGTH) collectionViewLayout:flow];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self. collectionView registerNib:[UINib nibWithNibName:Name bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCollectionCell];
}
#pragma mark - 代理 CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeBtnsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:[self.dataArray objectAtIndex:indexPath.item]];
    cell.label.text = [self.labelArray objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoManageViewController *info = [InfoManageViewController new];
    info.hidesBottomBarWhenPushed = YES;
    ParentsCenterViewController *parent = [ParentsCenterViewController new];
    parent.hidesBottomBarWhenPushed = YES;
    GrowUpViewController *member = [GrowUpViewController new];
    member.hidesBottomBarWhenPushed = YES;
    SettingCenterViewController *setting = [SettingCenterViewController new];
    setting.hidesBottomBarWhenPushed = YES;
    TeacherCommentViewController *teacher = [TeacherCommentViewController new];
    teacher.hidesBottomBarWhenPushed = YES;
    ConnectViewController *connect = [ConnectViewController new];
    connect.hidesBottomBarWhenPushed = YES;
    switch (indexPath.item) {
        case 0:
            
            [self.navigationController pushViewController:info animated:YES];
            break;
        case 1:
            
            [self.navigationController pushViewController:parent animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:member animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:setting animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:teacher animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:connect animated:YES];
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
