//
//  NoticeCenterTableViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/4.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "NoticeCenterTableViewCell.h"
@interface NoticeCenterTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation NoticeCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _lineView.layer.cornerRadius = 5;
    _lineView.layer.masksToBounds = YES;
    _lineView.layer.borderWidth = 1;
    _lineView.layer.borderColor = [UIColor colorWithWhite:0.702 alpha:1.000].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
