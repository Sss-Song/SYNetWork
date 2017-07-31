//
//  SYHTTPRequestTool.m
//  SYNetwork
//
//  Created by 宋成博 on 17/7/27.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import "SYHTTPRequestTool.h"
#import "PPNetworkHelper.h"

@implementation SYHTTPRequestTool

+(BOOL)isNetwork{

    return [PPNetworkHelper isNetwork];
}

+(BOOL)isWWANNetwork{

    return [PPNetworkHelper isWWANNetwork];
}

+(BOOL)isWiFiNetwork{

    return [PPNetworkHelper isWiFiNetwork];
}

+ (void)monitorNetworkStatus{
    
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                
            case PPNetworkStatusUnknown:
                NSLog(@"未知网络");
                break;
                
            case PPNetworkStatusNotReachable:
                NSLog(@"没有网络");
                break;
                
            case PPNetworkStatusReachableViaWWAN:
                NSLog(@"手机网络");
                break;
                
            case PPNetworkStatusReachableViaWiFi:
                NSLog(@"无线网络");
                break;
        }
        
    }];
}

+(NSURLSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters success:(SYRequestSeccess)success failure:(SYRequestFailed)failure{

   return [PPNetworkHelper POST:URL parameters:parameters success:^(id responseObject) {
       
       if (success) {
           success(responseObject);
       }
       
   } failure:^(NSError *error) {
       
       if (failure) {
          failure(error);
       }
   }];
}


+(NSURLSessionTask *)GET:(NSString *)URL parameters:(NSDictionary *)parameters success:(SYRequestSeccess)success failure:(SYRequestFailed)failure{

   return [PPNetworkHelper GET:URL parameters:parameters success:^(id responseObject) {
       
       if (success) {
           
           success(responseObject);
       }
       
   } failure:^(NSError *error) {
       
       if (failure) {
           
           failure(error);
       }
   }];

}

+(NSURLSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters successCache:(SYRequestCache)successCache success:(SYRequestSeccess)success failure:(SYRequestFailed)failure{

   return [PPNetworkHelper POST:URL parameters:parameters responseCache:^(id responseCache) {
      
       successCache?successCache(responseCache):nil;
      
   } success:^(id responseObject) {
      
       success?success(responseObject):nil;
      
   } failure:^(NSError *error) {
      
       failure?failure(error):nil;
   }];

}

@end
