//
//  NSString+Image.h
//  TreeLanguage
//
//  Created by DJL on 16/3/26.
//  Copyright © 2016年 llh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Image)
//图片转字符串
+(NSString *)UIImageToBase64Str:(UIImage *) image;
//字符串转图片
+(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;
@end
