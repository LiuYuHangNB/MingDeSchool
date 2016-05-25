//
//  RecordsOfHonorTableViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "RecordsOfHonorTableViewCell.h"

@interface RecordsOfHonorTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *aView;


@end
@implementation RecordsOfHonorTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _aView.layer.cornerRadius = 5;
    _aView.layer.masksToBounds = YES;
    _aView.layer.borderWidth = 1;
    _aView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
