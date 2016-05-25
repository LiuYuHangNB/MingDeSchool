//
//  FoodTableViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/11.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "FoodTableViewCell.h"

@interface FoodTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *materialsLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;

@end
@implementation FoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _imgView.image = [UIImage imageNamed:@"1"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
