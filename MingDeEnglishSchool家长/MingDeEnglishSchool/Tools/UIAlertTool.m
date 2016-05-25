//
//  UIAlertTool.m
//  AutoLayoutAnimation
//
//  Created by 刘宇航 on 15/12/17.
//  Copyright © 2015年 QC.L. All rights reserved.
//

#define IAIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import "UIAlertTool.h"
typedef void (^confirm)();
typedef void(^cancle)();

@interface UIAlertTool ()

{
    confirm confirmParam;
    cancle cancleParam;
    
}

@end

@implementation UIAlertTool

- (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle confirm:(void (^)())confirm cancle:(void (^)())cancle {
    
    confirmParam = confirm;
    cancleParam = cancle;
    if (IAIOS8) {
        
        // 创建alertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // 创建Acctions
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
            cancle();
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
            confirm();
            
        }];
        // 添加
        
        [alertController addAction:cancleAction];
        [alertController addAction:otherAction];
        
        [viewController presentViewController:alertController animated:YES completion:^{
            
        }];
        
    
        
        
    }else {
        
        UIAlertView *titleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
        
        [titleAlert show];
    }
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        confirmParam();
    }else {
        
        cancleParam();
    }
    
    
}



@end
