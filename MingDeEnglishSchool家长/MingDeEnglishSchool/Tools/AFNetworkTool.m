//
//  AFNetworkTool.m
//  Moon
//
//  Created by liuiyuhang on 15/11/6.
//  Copyright © 2015年 刘宇航. All rights reserved.
//

#import "AFNetworkTool.h"
#import "AFNetworking.h"

@implementation AFNetworkTool


+ (void)getUrl:(NSString*)url body:(id)body response:(ResposeStyle)style requestHeadFile:(NSDictionary *)headFile success:(void(^)(NSURLSessionDataTask *task,id resposeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    //1.获取单例的网络管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.根据style 的类型 去选择返回值得类型
    switch (style) {
        case JSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case Data:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    //3.设置相应数据支持的类型
     [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    //4.给网络请求加请求头
    if (headFile) {
        for (NSString * key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
        
    }
    //5.UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 2.0
    //6.发送GET请求
//    [manager GET:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        if (success) {
//            success(task, responseObject);
//            
//
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure (task, error);
//
//        }
//        
//    }];
    //3.0
    /* 6.发送get请求 */
    [manager GET:url parameters:body progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /* ************************************************** */
        //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
        // 存储的沙盒路径
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 归档
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        if (success) {
            
            success(task, responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            
            /* *************************************************** */
            // 在这里读取本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            
            id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
            
            if (result) {
                success(task, result);
            }else{
                failure(task,error);
            }
            
        }

        
    }];
    
//    [manager GET:url parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        /* ************************************************** */
//        //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
//        NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
//        // 存储的沙盒路径
//        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        // 归档
//        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
//        
//        
//        /* if判断， 防止success 为空 */
//        if (success) {
//            
//            success(task, responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        if (error) {
//            
//            /* *************************************************** */
//            // 在这里读取本地缓存
//            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
//            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            
//            id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
//            
//            if (result) {
//                success(task, result);
//            }else{
//                failure(task,error);
//            }
//            
//            //            failure(task, error);
//        }
//        
//    }];
    
}
#pragma mark ------post
+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(ResposeStyle)style
            bodyStyle:(RequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获取Session管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置网络请求返回时, responseObject的数据类型
    switch (style) {
        case JSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case Data:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    // 3.判断body体的类型
    switch (bodyStyle) {
        case RequestJSON:
            // 以JSON格式发送
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case RequestString:
            // 保持字符串样式
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
                return parameters;
            }];
        case RequestDefault:
            // 默认情况会把JSON拼接成字符串, 但是没有顺序
            break;
            
        default:
            break;
    }
    // 4.给网络请求加请求头
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    // 5.设置支持的响应头格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    // 6.发送网络请求
    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(task, responseObject);

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(task, error);

        }
        
    }];
    
    
//    [manager POST:url parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
//        if (success) {
//            success(task, responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failure) {
//            failure(task, error);
//        }
//    }];
    
    
}

+ (void)upLoadToUrlString:(NSString *)url parameters:(NSDictionary *)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType              response:(ResposeStyle)style
 progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    //1.获取单例的网络管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.根据style 的类型 去选择返回值得类型
    switch (style) {
        case JSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case Data:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }

    //3.设置相应数据支持的类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(task, responseObject);
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(task, error);
            
        }
    }];
    
}


@end
