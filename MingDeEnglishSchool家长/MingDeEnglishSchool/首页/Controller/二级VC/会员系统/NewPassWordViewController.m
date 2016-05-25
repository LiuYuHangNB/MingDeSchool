//
//  NewPassWordViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/20.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "NewPassWordViewController.h"

@interface NewPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstField;
@property (weak, nonatomic) IBOutlet UITextField *secondField;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation NewPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commitButton.layer.borderWidth = 1;
    _commitButton.layer.borderColor = [UIColor colorWithRed:0.824 green:0.627 blue:0.984 alpha:1.000].CGColor;
    
    

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
