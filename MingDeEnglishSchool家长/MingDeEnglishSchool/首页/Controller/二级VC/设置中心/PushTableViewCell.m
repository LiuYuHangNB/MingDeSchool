//
//  PushTableViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/11.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "PushTableViewCell.h"

@interface PushTableViewCell ()
@property (weak, nonatomic) IBOutlet UISwitch *swi;
@end

@implementation PushTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _swi.tintColor = [UIColor colorWithRed:0.800 green:0.400 blue:1.000 alpha:1.000];
//    _swi.onTintColor = []
}


- (IBAction)handleSwitch:(id)sender {
    
    UISwitch *swi = (UISwitch *)sender;
    self.SwitchBlock(swi);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
