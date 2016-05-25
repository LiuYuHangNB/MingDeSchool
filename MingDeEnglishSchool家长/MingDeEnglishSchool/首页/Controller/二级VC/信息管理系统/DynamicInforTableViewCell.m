//
//  DynamicInforTableViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "DynamicInforTableViewCell.h"

@interface DynamicInforTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end
@implementation DynamicInforTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imgView.image = [UIImage imageNamed:@"1"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
