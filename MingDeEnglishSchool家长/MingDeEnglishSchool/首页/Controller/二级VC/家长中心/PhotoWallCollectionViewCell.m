//
//  PhotoWallCollectionViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/4.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "PhotoWallCollectionViewCell.h"

@interface PhotoWallCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *zanView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation PhotoWallCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _lineView.layer.borderWidth = 1;
    _lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
