//
//  LoginViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/25.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "LoginViewController.h"
#import "RetrievePasswordViewController.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *waringButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet UIButton *rememberThePassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTheField];
    
}
#pragma mark - x 按钮

- (IBAction)handleDismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - 设置输入账号密码的TextField
- (void)setTheField {
    // 用户名图标
    UIView *paddingViewForUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, self.userNameField.frame.size.height)];
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameField.leftView = paddingViewForUserName;
    UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b27_icon_star_yellow"]];
    [paddingViewForUserName addSubview:userImage];
    userImage.center = paddingViewForUserName.center;
    
    UIView *paddingViewForPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, self.passWordField.bounds.size.height)];
    self.passWordField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordField.leftView = paddingViewForPassword;
    UIImageView *passwordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b27_icon_star_yellow"]];
    [paddingViewForPassword addSubview:passwordImage];
    passwordImage.center = paddingViewForPassword.center;
    self.waringButton.hidden = YES;
}

- (IBAction)rememberPassWordClick:(id)sender {
    
    
    
}
- (IBAction)forgetPassWordClick:(id)sender {
    
    RetrievePasswordViewController *passWorld = [RetrievePasswordViewController new];
    
    [self.navigationController pushViewController:passWorld animated:YES];
    
}
- (IBAction)loginClick:(id)sender {
    
    
    self.loginButton.transform = CGAffineTransformMakeTranslation(-30, 0);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.waringButton.hidden = YES;
        self.loginButton.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        if ([self.userNameField.text isEqualToString:@""] || [self.passWordField.text isEqualToString:@""]) {
            [self showError:@"用户名和密码不能为空"];
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:_userNameField.text forKey:@"userName"];
            [defaults setObject:_passWordField.text forKey:@"passWorld"];
            
            [defaults synchronize];
            
            //登录
        }
    }];

//    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)showError:(NSString *)err {
    [UIView animateWithDuration:0.4 animations:^{
        self.loginButton.transform = CGAffineTransformMakeTranslation(0, 70);
    }];
    [UIView transitionWithView:self.waringButton duration:0.4 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.waringButton.hidden = NO;
        [self.waringButton setTitle:err forState:UIControlStateNormal];
    } completion:nil];
    
    
}

// 点击空白键盘回收
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
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
