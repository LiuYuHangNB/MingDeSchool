//
//  PushTableViewCell.h
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/5/11.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^SwitchBlock)(UISwitch*);
@end
