//
//  RetrievePasswordViewController.m
//  
//
//  Created by 刘宇航 on 16/5/6.
//
//

#import "RetrievePasswordViewController.h"
#import "BaseHeader.h"
#import "NewPassWordViewController.h"
@interface RetrievePasswordViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *VerificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *GetVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation RetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nextButton.layer.borderWidth = 1;
    _nextButton.layer.borderColor = [UIColor colorWithRed:210 / 255. green:160 / 255. blue:251 / 255. alpha:1].CGColor;
    
    _phoneNumTextField.layer.borderWidth = 1;
    _phoneNumTextField.layer.borderColor = [UIColor colorWithWhite:0.600 alpha:1.000].CGColor;
    
    _VerificationTextField.layer.borderWidth = 1;
    _VerificationTextField.layer.borderColor = [UIColor colorWithWhite:0.600 alpha:1.000].CGColor;

}
- (IBAction)GetVerificationCode:(id)sender {
    
}
- (IBAction)nextButton:(id)sender {
    
    NewPassWordViewController *newPassword = [NewPassWordViewController new];
    [self.navigationController pushViewController:newPassword animated:YES];
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
