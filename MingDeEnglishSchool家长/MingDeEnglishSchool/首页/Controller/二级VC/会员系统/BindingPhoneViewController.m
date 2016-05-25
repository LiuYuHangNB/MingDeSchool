//
//  BindingPhoneViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/20.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "BindingPhoneViewController.h"

@interface BindingPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *showNum;


@end

@implementation BindingPhoneViewController
- (IBAction)getNumberClick:(id)sender {
}
- (IBAction)completeClick:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _phoneNum.layer.borderWidth = 1;
    _phoneNum.layer.borderColor = [UIColor colorWithWhite:0.600 alpha:1.000].CGColor;
    _showNum.layer.borderWidth = 1;
    _showNum.layer.borderColor = [UIColor colorWithWhite:0.600 alpha:1.000].CGColor;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
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
