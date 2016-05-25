//
//  AppDelegate.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseHeader.h"
#import "EaseMob.h"
#import "TabBarController.h"
@interface AppDelegate ()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView *scrollView;
@property (nonatomic, retain)UIPageControl *pageControl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 1.修改状态栏背景颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 2.设置启动页面时间
    [NSThread sleepForTimeInterval:2.0];
    // 3.环信部分
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    //pyyym#1是我申请的appkey，123456是证书名字
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"l44572265#mingdeparents" apnsCertName:@"develop"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    // 环信注册
    /*
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:@"parentsMing" password:@"201218"withCompletion:^(NSString *username, NSString *password, EMError *error) {
        NSLog(@"%@",error);
        if (!error) {
            NSLog(@"注册成功");
        }
    } onQueue:nil];
    // 环信登录
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"parentsMing" password:@"201218" completion:^(NSDictionary *loginInfo, EMError *error) {
        
        NSLog(@"%@",error);
        
        if (!error && loginInfo) {
            
            NSLog(@"登录成功%@",loginInfo);
            
            [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
            
            
        }
    } onQueue:nil];
*/
    
    [self firstEnter];
    
//    NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    NSLog(@"===%@",remoteNotification);
    return YES;
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
//    NSLog(@"注册deviceToken失败:error %@",error);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"---%@",userInfo);
    
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
//    NSLog(@"--------%@",userInfo);
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.content", @"Apns content")
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    NSLog(@"-------%@",notification.userInfo);
}
#pragma mark --------设置第一次进入引导页---------

- (void)firstEnter {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //取值
    NSString *result = [userDefault objectForKey:@"firstTime"];
    
    if (result == nil) {
        
        UIViewController *Enter = [[UIViewController alloc]init];
        /** 滚动条 */
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGTH)];
        self.scrollView.contentSize = CGSizeMake(SWIDTH * 3, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [Enter.view addSubview:self.scrollView];
        self.window.rootViewController = Enter;
        for (NSInteger i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * SWIDTH, 0, SWIDTH, SHEIGTH)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%ld",(long)i]];
            [self.scrollView addSubview:imageView];
        }
        /** pageControl*/
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH / 30, SHEIGTH - 60 * HEIGTH , SWIDTH, 20 * HEIGTH)];
        self.pageControl.numberOfPages = 3;
        [self.pageControl addTarget:self action:@selector(handlePage:) forControlEvents:UIControlEventValueChanged];
        //非当前点的颜色
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //当前点的颜色
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
        [self.window addSubview:self.pageControl];
        /** Button*/
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(SWIDTH * 2, 0, SWIDTH, SHEIGTH);
        [button setTitle:@"" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(firstEnter:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:button];
        
        //写入磁盘
        [userDefault setObject:@"Parents" forKey:@"firstTime"];
        [userDefault synchronize];

    }else {
        
        [self createTabBar];
        
    }
    
}
#pragma mark ————————————第一次进入方法
- (void)firstEnter:(UIButton *)button {
    
    [self createTabBar];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = self.scrollView.contentOffset.x / SWIDTH;
}

- (void)handlePage:(UIPageControl *)page {
    
    [self.scrollView setContentOffset:CGPointMake(page.currentPage * SWIDTH, 0) animated:YES];
}

- (void)createTabBar {

    TabBarController *tabBar = [[TabBarController alloc]init];
    self.window.rootViewController = tabBar;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillTerminate:application];

    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "LYH.MingDeEnglishSchool" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MingDeEnglishSchool" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MingDeEnglishSchool.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
