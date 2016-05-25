//
//  WeekRecipeViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/4.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "WeekRecipeViewController.h"
#import "BaseHeader.h"
@interface WeekRecipeViewController ()

@end

@implementation WeekRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    //Need You Edit
    /**<  上方显示标题  Titles showing on the topTab   **/
    NSArray *titleArray =   @[
                              @"周一",
                              @"周二",
                              @"周三",
                              @"周四",
                              @"周五"
                              ];
    /**< 每个标题下对应的控制器，只需将您创建的控制器类名加入下列数组即可(注意:数量应与上方的titles数量保持一致，若少于titles数量，下方会打印您缺少相应的控制器，同时默认设置的最大控制器数量为10=。=)
     **/
    NSArray *vcsArray = @[
                          @"FirstTableViewController",
                          @"SecondTableViewController",
                          @"ThirdTableViewController",
                          @"FourTableViewController",
                          @"FiveTableViewController",
                          ];
    /**< 您可以选择是否要改变标题选中的颜色(默认为黑色)、未选中的颜色(默认为灰色)或者下划线的颜色(默认为色值是ff6262)，上方菜单栏背景色(默认为白色)。如果传入颜色数量不够，则按顺序给相应的部分添加颜色。
     **/
    NSArray *colorArray = @[
                            [UIColor colorWithRed:210 / 255. green:160 / 255. blue:251 / 255. alpha:1], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor blackColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor colorWithRed:210 / 255. green:160 / 255. blue:251 / 255. alpha:1], /**< 下划线颜色 Underline Color   **/
                            [UIColor whiteColor], /**<  上方菜单栏的背景颜色 TopTab Background Color   **/
                            ];
    /**< 创建ninaPagerView，控制器第一次是根据您划的位置进行相应的添加的，类似网易新闻虎扑看球等的效果，后面再滑动到相应位置时不再重新添加，如果想刷新数据，您可以在相应的控制器里加入刷新功能，低耦合。需要注意的是，在创建您的控制器时，设置的frame为FUll_CONTENT_HEIGHT，即全屏高减去导航栏高度再减去Tabbar的高度，如果这个高度不是您想要的，您可以去UIParameter.h中进行设置XD。
     **/
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    //    ninaPagerView.delegate = self;
    [self.view addSubview:ninaPagerView];


}



- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
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
