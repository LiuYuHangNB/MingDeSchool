//
//  TeacherCommentTableViewCell.m
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import "TeacherCommentTableViewCell.h"

@interface TeacherCommentTableViewCell ()


@end
@implementation TeacherCommentTableViewCell


- (IBAction)EvaluationButtonClick:(id)sender {

    if (self.clickBlock) {
        
        self.clickBlock();
    }
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
