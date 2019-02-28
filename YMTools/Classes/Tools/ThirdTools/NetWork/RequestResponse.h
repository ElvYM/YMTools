//
//  RequestResponse.h
//  YMTools
//
//  Created by longxian on 2018/5/19.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestResponse : NSObject

/** 错误 */
@property (nonatomic, strong) NSError *error;

/** 错误提示 */
@property (nonatomic, copy) NSString *errorMsg;

/** 错误码 */
@property (assign, nonatomic) NSInteger statusCode;

/** 响应头 */
@property (nonatomic, copy) NSMutableDictionary *headers;

/** 响应体 */
@property (nonatomic, strong) id responseObject;

@end
