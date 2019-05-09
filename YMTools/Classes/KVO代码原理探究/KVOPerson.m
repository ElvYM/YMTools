//
//  KVOPerson.m
//  YMTools
//
//  Created by jike on 2018/1/8.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "KVOPerson.h"
#import <objc/objc.h>
#import <objc/runtime.h>
@implementation KVOPerson
-(void)careDog:(id)dog {
    [self setValue:dog forKey:@"aDog"];
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}

<<<<<<< HEAD
-(void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey");
}

=======
>>>>>>> 8b86b9a983b53b4c245521957c7678fa7c253334
@end
