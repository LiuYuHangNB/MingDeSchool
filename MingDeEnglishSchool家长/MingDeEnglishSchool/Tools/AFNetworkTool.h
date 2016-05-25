//
//  AFNetworkTool.h
//  Moon
//
//  Created by liuiyuhang on 15/11/6.
//  Copyright © 2015年 刘宇航. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ResposeStyle) {
    JSON,
    XML,
    Data,
};

typedef NS_ENUM(NSUInteger, RequestStyle) {
    RequestJSON,
    RequestString,
    RequestDefault
};

@interface AFNetworkTool : NSObject

/**
 *  GET请求
 */
+ (void)getUrl:(NSString*)url
          body:(id)body
      response:(ResposeStyle)style
requestHeadFile:(NSDictionary *)headFile
       success:(void(^)(NSURLSessionDataTask *task,id resposeObject))success
       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  POST 请求
 */
+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(ResposeStyle)style
            bodyStyle:(RequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  上传
 *
 *  @param url        服务器地址
 *  @param parameters 字典 token
 *  @param fileData   要上传的数据
 *  @param name       服务器参数名称
 *  @param fileName   文件名称 图片:xxx.jpg,xxx.png     视频:video.mov
 *  @param mimeType   文件类型 图片:image/jpg,image/png 视频:video/quicktime
 *  @param style      返回的数据类型
 *  @param progress
 *  @param success
 *  @param failure
 */
+ (void)upLoadToUrlString:(NSString *)url
               parameters:(NSDictionary *)parameters
                     fileData:(NSData *)fileData
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 mimeType:(NSString *)mimeType
                 response:(ResposeStyle)style
                 progress:(void(^)(NSProgress *uploadProgress))progress
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
;



@end
