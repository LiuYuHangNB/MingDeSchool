//
//  SubmitEvaluationViewController.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "SubmitEvaluationViewController.h"
#import "BaseHeader.h"
@interface SubmitEvaluationViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *kindLabel;
@property (nonatomic, strong) UILabel *labelOne;
@property (nonatomic, strong) UILabel *labelTwo;
@property (nonatomic, strong) UILabel *labelThree;
@property (nonatomic, strong) UILabel *labelFour;
@property (nonatomic, strong) UILabel *labelFive;
@property (nonatomic, strong) XHStarRateView *starView;


@property (nonatomic, strong) UITextView *textView;

@end

@implementation SubmitEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubViews];
}

- (void)initSubViews {
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * HEIGTH, 64 + 10 * HEIGTH , 60 * WIDTH, 60 * WIDTH)];
    _imageView.backgroundColor = COLOR;
    _imageView.layer.cornerRadius = 30 * WIDTH;
    _imageView.layer.masksToBounds = YES;
    [self.view addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90 * WIDTH, 64 + 10 * HEIGTH, 70 * WIDTH, 20 * HEIGTH)];
    _nameLabel.font = [UIFont systemFontOfSize:15.0];
    _nameLabel.text = @"莫莫莫";
    [self.view addSubview:_nameLabel];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90 * WIDTH, 64 + 50 * HEIGTH, 60 * WIDTH, 20 * HEIGTH)];
    label.text = @"职务:";
    label.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:label];
    
    _kindLabel = [[UILabel alloc] initWithFrame:CGRectMake(130 * WIDTH, 64 + 50 * HEIGTH, 70 * WIDTH, 20 * HEIGTH)];
    _kindLabel.font = [UIFont systemFontOfSize:13.0];
    _kindLabel.text = @"语文老师";
    [self.view addSubview:_kindLabel];
    
    UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 80 * HEIGTH, SWIDTH, 1)];
    oneView.backgroundColor = COLOR;
    [self.view addSubview:oneView];
    
    _labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 90 * HEIGTH, SWIDTH / 3, 30 * HEIGTH)];
    _labelOne.text = @"上课风格";
    [self.view addSubview:_labelOne];
    
    _labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 120 * HEIGTH, SWIDTH / 3, 30 * HEIGTH)];
    _labelTwo.text = @"上课风格";
    [self.view addSubview:_labelTwo];
    
    _labelThree= [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 150 * HEIGTH, SWIDTH / 3, 30 * HEIGTH)];
    _labelThree.text = @"上课风格";
    [self.view addSubview:_labelThree];
    
    _labelFour = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 180 * HEIGTH, SWIDTH / 3, 30 * HEIGTH)];
    _labelFour.text = @"上课风格";
    [self.view addSubview:_labelFour];
    
    _labelFive = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 210 * HEIGTH, SWIDTH / 3, 30 * HEIGTH)];
    _labelFive.text = @"上课风格";
    [self.view addSubview:_labelFive];
    
    XHStarRateView *starViewOne = [[XHStarRateView alloc] initWithFrame:CGRectMake(SWIDTH * 2 / 3 - 10, 64 + 90 * HEIGTH, SWIDTH / 3, 30 * HEIGTH) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"1---  %f",currentScore);

    }];
    [self.view addSubview:starViewOne];
    
    XHStarRateView *starViewTwo = [[XHStarRateView alloc] initWithFrame:CGRectMake(SWIDTH * 2 / 3 - 10, 64 + 120 * HEIGTH, SWIDTH / 3, 30 * HEIGTH) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"2---  %f",currentScore);
        
    }];
    [self.view addSubview:starViewTwo];
    
    XHStarRateView *starViewThree = [[XHStarRateView alloc] initWithFrame:CGRectMake(SWIDTH * 2 / 3 - 10, 64 + 150 * HEIGTH, SWIDTH / 3, 30 * HEIGTH) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"3---  %f",currentScore);
        
    }];
    [self.view addSubview:starViewThree];
    
    XHStarRateView *starViewFour = [[XHStarRateView alloc] initWithFrame:CGRectMake(SWIDTH * 2 / 3 - 10, 64 + 180 * HEIGTH, SWIDTH / 3, 30 * HEIGTH) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"4---  %f",currentScore);
        
    }];
    [self.view addSubview:starViewFour];
    
    XHStarRateView *starViewFive = [[XHStarRateView alloc] initWithFrame:CGRectMake(SWIDTH * 2 / 3 - 10, 64 + 210 * HEIGTH, SWIDTH / 3, 30 * HEIGTH) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"5---  %f",currentScore);
        
    }];
    [self.view addSubview:starViewFive];
    
    UIView *twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 250 * HEIGTH, SWIDTH, 1)];
    twoView.backgroundColor = COLOR;
    [self.view addSubview:twoView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 64 + 260 * HEIGTH, SWIDTH - 20, 100 * HEIGTH)];
    _textView.delegate = self;
    _textView.text = @"我们需要您的评价...";
    _textView.layer.cornerRadius = 8;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 1.0;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.font = [UIFont systemFontOfSize:15.0];
    _textView.textAlignment = NSTextAlignmentLeft;
    self.textView.scrollEnabled = YES;
    self.textView.autoresizingMask =
    UIViewAutoresizingFlexibleHeight; //自适应高度
    self.textView.returnKeyType = UIReturnKeyDefault; //返回键的类型
    self.textView.keyboardType = UIKeyboardTypeDefault; //键盘类型
    [self.view addSubview:_textView];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(280 * WIDTH, 64 + 370 * HEIGTH, 80 * WIDTH, 25);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR;
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    
    [self.view addSubview:submitButton];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _textView.text = @"";
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
