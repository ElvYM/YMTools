//
//  VersionUpdate.h
//  LazyCat
//
//  Created by longxian on 2018/5/2.
//  Copyright © 2018年 zhanshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionUpdate : NSObject
+ (BOOL)versionUpdateCheckByAppid:(NSString *)appid;
@end
