//
//  TabBarController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/24.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "TabBarController.h"
#import "BaseHeader.h"
#import "HomeViewController.h"
#import "SettingCenterViewController.h"
#import "MemberViewController.h"
#import "NoticeCenterViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    UIImage* homeImage = [UIImage imageNamed:@"whiteHome"];
    //声明这张图片用原图(别渲染)
    homeImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    UIImage* messageImage = [UIImage imageNamed:@"whiteMessage"];
    //声明这张图片用原图(别渲染)
    messageImage = [messageImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //
    UIImage* setImage = [UIImage imageNamed:@"whiteSetting"];
    //声明这张图片用原图(别渲染)
    setImage = [setImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage* myImage = [UIImage imageNamed:@"whiteMy"];
    //声明这张图片用原图(别渲染)
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    HomeViewController *home = [HomeViewController new];
    UINavigationController *homeNC = [[UINavigationController alloc] initWithRootViewController:home];
    home.tabBarItem.image = homeImage;
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"yellowHome"];
    home.tabBarItem.title = @"首页";
    [home.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    
    NoticeCenterViewController *mess = [NoticeCenterViewController new];
    UINavigationController *messNC = [[UINavigationController alloc] initWithRootViewController:mess];
    
    mess.tabBarItem.image = messageImage;
    mess.tabBarItem.selectedImage = [UIImage imageNamed:@"yellowMessage"];
    mess.tabBarItem.title = @"消息";
    [mess.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    SettingCenterViewController *set = [SettingCenterViewController new];
    UINavigationController *setNC = [[UINavigationController alloc] initWithRootViewController:set];
    set.tabBarItem.image = setImage;
    set.tabBarItem.selectedImage = [UIImage imageNamed:@"yellowSetting"];
    set.tabBarItem.title = @"设置";
    [set.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    MemberViewController *my = [MemberViewController new];
    UINavigationController *myNC = [[UINavigationController alloc] initWithRootViewController:my];
    my.tabBarItem.image = myImage;
    my.tabBarItem.selectedImage = [UIImage imageNamed:@"yellowMy"];
    my.tabBarItem.title = @"会员";
    [my.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    self.viewControllers = @[homeNC, messNC, setNC, myNC];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
    backView.backgroundColor = COLOR;
    
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    self.tabBar.tintColor = [UIColor yellowColor];
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
