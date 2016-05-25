//
//  UIAlertTool.h
//  AutoLayoutAnimation
//
//  Created by 刘宇航 on 15/12/17.
//  Copyright © 2015年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertTool : NSObject

- (void)showAlertView :(UIViewController *)viewController title:(NSString *)title message :(NSString *) message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle :(NSString *)otherButtonTitle confirm:(void (^)())confirm cancle:(void (^)())cancle;




@end
