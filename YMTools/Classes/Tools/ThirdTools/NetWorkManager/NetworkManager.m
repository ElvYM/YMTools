//
//  NetworkManager.m
//  YMTools
//
//  Created by longxian on 2018/5/28.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "NetworkManager.h"
#import <RealReachability.h>

@interface NetworkManager()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic,strong) AFJSONResponseSerializer *jsonResponseSerializer;
@property (nonatomic,strong) AFHTTPResponseSerializer *httpResponseSerializer;
@end

@implementation NetworkManager
+(instancetype)shareInstance {
    static NetworkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkManager alloc] init];
        manager.sessionManager = [AFHTTPSessionManager manager];
    });
    return manager;
}

-(void)setRequestCookie:(NSString *)cookie {
    [self.sessionManager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
}

-(NSURLSessionDataTask *)get:(NSString *)url params:(id)params responseType:(ResponseType)responseType success:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure {
    [self m_configResponseForType:responseType];
    return [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject, task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, task);
        }
    }];
}

- (NSURLSessionDataTask *)post:(NSString *)url params:(id)params responseType:(ResponseType)responseType success:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure {
    [self m_configResponseForType:responseType];
    return [self.sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,task);
        }
    }];
}

- (NSURLSessionDataTask *)HEAD:(NSString *)url params:(id)params responseType:(ResponseType)responseType success:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure {
    [self m_configResponseForType:responseType];
    return [self.sessionManager HEAD:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task) {
        if (success) {
            success(nil,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,task);
        }
    }];
}

- (void)post:(NSString *)url prefixStr:(NSString *)prefix params:(NSDictionary *)params success:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure {
    
    NSMutableURLRequest *request = [self m_createMutableURLRequestWithUrl:url prefix:prefix params:params];
    
    [[self.sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error, nil);
            }
        }
        else {
            if (success) {
                success(responseObject, nil);
            }
        }
    }] resume];

}

- (void)m_configResponseForType:(ResponseType)type {
    switch (type) {
        case ResponseTypeJSON:
            self.sessionManager.responseSerializer = self.jsonResponseSerializer;
            break;
            
        case ResponseTypeHTTP:
            self.sessionManager.responseSerializer = self.httpResponseSerializer;
            break;
        default:
            break;
    }
}

- (NSMutableURLRequest *)m_createMutableURLRequestWithUrl:(NSString *)url prefix:(NSString *)prefix params:(id)params {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *bodyString=[NSString stringWithFormat:@"%@%@",prefix,jsonString];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

#pragma mark - getter
-(AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _jsonResponseSerializer;
}

-(AFHTTPResponseSerializer *)httpResponseSerializer {
    if (!_httpResponseSerializer) {
        _httpResponseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _httpResponseSerializer;
}

#pragma mark - network state
- (void)startMonitorNetworkType {
    [GLobalRealReachability startNotifier];
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:kRealReachabilityChangedNotification object:nil]
      distinctUntilChanged]
     subscribeNext:^(NSNotification *notification) {
         RealReachability *reachability = (RealReachability *)notification.object;
         ReachabilityStatus status = [reachability currentReachabilityStatus];
         NSString *state;
         BOOL isReachable = YES;
         BOOL isNeeNotice = YES;
         switch (status) {
             case RealStatusNotReachable:
             {
                 state = @"网络已断开";
                 isReachable = NO;
             }
                 break;
             case RealStatusViaWiFi:
             {
                 state = @"已切换到 WIFI";
             }
                 break;
             case RealStatusViaWWAN:
             {
                 WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
                 if (accessType == WWANType2G)
                 {
                     state = @"已切换到 2G";
                 }
                 else if (accessType == WWANType3G)
                 {
                     state = @"已切换到 3G";
                 }
                 else if (accessType == WWANType4G)
                 {
                     state = @"已切换到 4G";
                 }
             }
                 break;
             default:
             {
                 isNeeNotice = NO;
             }
                 break;
         }
         
         if (isNeeNotice) {
             if (isReachable) {
//                 [ZHNHudManager showWarning:state];
             }else {
//                 [ZHNHudManager showError:state];
             }
         }
     }];
}

- (BOOL)isWIFI {
    if ([GLobalRealReachability currentReachabilityStatus] == RealStatusViaWiFi) {
        return YES;
    }else {
        return NO;
    }
}
@end
