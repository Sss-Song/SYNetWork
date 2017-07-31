//
//  SYHTTPRequestTool.h
//  SYNetwork
//
//  Created by 宋成博 on 17/7/27.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求成功block
typedef void(^SYRequestSeccess)(id responseObject);
//请求失败block
typedef void(^SYRequestFailed)(NSError *error);
//缓存block
typedef void(^SYRequestCache)(id responseObject);

@interface SYHTTPRequestTool : NSObject

/**
 *  监听网络状态(自动回调)
 */
+(void)monitorNetworkStatus;


/**
 *  判断是否有网络
 */
+(BOOL)isNetwork;


/**
 *  判断手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;


/**
 *  判断WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;


/**
 *  POST请求 无缓存
 */
+(NSURLSessionTask *)POST :(NSString *)URL parameters:(NSDictionary *)parameters success:(SYRequestSeccess)success failure:(SYRequestFailed)failure;


/**
 *  GET请求 无缓存
 */
+(NSURLSessionTask *)GET :(NSString *)URL parameters:(NSDictionary *)parameters success:(SYRequestSeccess)
    success failure:(SYRequestFailed)failure;

/**
 *  POST 带缓存
 */
+(NSURLSessionTask *)POST:(NSString *)URL
                          parameters:(NSDictionary *)parameters
                          successCache:(SYRequestCache)successCache
                          success:(SYRequestSeccess)success
                          failure:(SYRequestFailed)failure;
/**
 *  GET 带缓存
 */
+(NSURLSessionTask *)GET:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                         successCache:(SYRequestCache)successCache
                         success:(SYRequestSeccess)success
                         failure:(SYRequestFailed)failure;
@end





