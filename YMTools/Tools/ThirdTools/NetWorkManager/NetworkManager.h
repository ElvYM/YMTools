//
//  NetworkManager.h
//  YMTools
//
//  Created by longxian on 2018/5/28.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#define NNETWROK [NetworkManager shareInstance]

typedef NS_ENUM(NSInteger, ResponseType) {
    ResponseTypeJSON,
    ResponseTypeHTTP
};

typedef void (^NetworkSuccessHandle) (id result, NSURLSessionTask *task);
typedef void (^NetworkFailureHandle) (NSError *error, NSURLSessionTask *task);

@interface NetworkManager : NSObject
/**
 Create manager
 
 @return manager
 */
+(instancetype)shareInstance;


/**
 Start monitor network
 */
- (void)startMonitorNetworkType;


/**
 Judge is wifi ?
 
 @return isWIFI
 */
- (BOOL)isWIFI;


/**
 Set request cookie
 
 @param cookie cookie
 */
- (void)setRequestCookie:(NSString *)cookie;

- (NSURLSessionDataTask *)get:(NSString *)url
                       params:(id)params
                 responseType:(ResponseType)responseType
                      success:(NetworkSuccessHandle)success
                      failure:(NetworkFailureHandle)failure;


- (NSURLSessionDataTask *)post:(NSString *)url
                        params:(id)params
                  responseType:(ResponseType)responseType
                       success:(NetworkSuccessHandle)success
                       failure:(NetworkFailureHandle)failure;


/**
 Post string
 */
- (void)post:(NSString *)url
                   prefixStr:(NSString *)prefix
                  params:(NSDictionary *)params
                       success:(NetworkSuccessHandle)success
                       failure:(NetworkFailureHandle)failure;

- (NSURLSessionDataTask *)HEAD:(NSString *)url
                        params:(id)params
                  responseType:(ResponseType)responseType
                       success:(NetworkSuccessHandle)success
                       failure:(NetworkFailureHandle)failure;

@end
