//
//  AFRequestManager.h
//  YMTools
//
//  Created by longxian on 2018/5/19.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "RequestResponse.h"
#import <AFNetworking.h>

typedef enum : NSInteger {
    // 自定义错误码
    LMJRequestManagerStatusCodeCustomDemo = -10000,
} LMJRequestManagerStatusCode;

typedef RequestResponse *(^ResponseFormat)(RequestResponse *response);

@interface AFRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;

- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(RequestResponse *response))completion;

- (void)POST:(NSString *)urlString perfixStr:(NSString *)perfix parameters:(NSDictionary *)parameters completion:(void (^)(RequestResponse *response))completion;

- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(RequestResponse *response))completion;



/**
 data 对应的二进制数据
 name 服务端需要参数
 */
- (void)upload:(NSString *)urlString parameters:(id)parameters formDataBlock:(void(^)(id<AFMultipartFormData> formData))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(RequestResponse *response))completion;

@end
