//
//  RequestResponse.m
//  YMTools
//
//  Created by longxian on 2018/5/19.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "RequestResponse.h"

@implementation RequestResponse
- (NSString *)description
{
    return [NSString stringWithFormat:@"\n状态吗: %zd,\n错误: %@,\n响应头: %@,\n响应体: %@", self.statusCode, self.error, self.headers, self.responseObject];
}

- (void)setError:(NSError *)error {
    _error = error;
    self.statusCode = error.code;
    self.errorMsg = error.localizedDescription;
}
@end
