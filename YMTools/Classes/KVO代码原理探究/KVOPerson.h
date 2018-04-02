//
//  KVOPerson.h
//  YMTools
//
//  Created by jike on 2018/1/8.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOPerson : NSObject
@property (copy, nonatomic)NSString  * cat;

@property (strong, nonatomic ,readonly)NSString  * aDog;

-(void)careDog:(id)dog;
@end
