//
//  RealmUsageViewController.m
//  YMTools
//
//  Created by Y on 2019/2/27.
//  Copyright © 2019 YM. All rights reserved.
//

#import "RealmUsageViewController.h"
#import "Friends.h"
@interface RealmUsageViewController ()

@end

@implementation RealmUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self realm];
}

- (void)realm {

    for (int i = 0; i < 10; i++) {
        [self r_add];
    }
    
    [self r_search];
    
    [self r_delete];
    
    [self r_update];

}


/**
 添加数据
 */
- (void)r_add {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    int firstIndex = arc4random() % 10000;

    Friends *friend = [Friends new];
    friend.name = [NSString stringWithFormat:@"Yao%d",firstIndex];
    friend.face = @"https://github.com/ElvYM";
    friend.desc = @"iOS";
    friend.friendsId = firstIndex;
    friend.groupId = 2;
    
    
    // 存储对象
    // 方法1
    [realm transactionWithBlock:^{
        [realm addObject:friend];
    }];
    
    // 方法2
    //开启事务
    //    [realm beginWriteTransaction];
    //    // 存储对象
    //    [realm addObject:friend];
    //    // 提交事务
    //    [realm commitWriteTransaction];
}


/**
 查
 */
- (void)r_search {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //表内所有数据
    RLMResults *results = [Friends allObjects];
    
    //条件查询
    RLMResults *results1 = [Friends objectsWhere:@"friendsId > 2"];
    

}


/**
 删
 */
- (void)r_delete {
    // *删除数据
    RLMResults *results = [Friends objectsWhere:@"friendsId = %d",1];
    Friends *resutlFriend = results.firstObject;
    
    // 删除单条数据
    //    [realm transactionWithBlock:^{
    //        [realm deleteObject:resutlFriend];
    //    }];
    
    // 删除表数据
    // 获取表数据
    //    RLMResults *allFriends = [Friends allObjects];
    //    for (Friends *friend in allFriends) {
    //        [realm deleteObject:friend];
    //    }
    
    // 清除所有数据
    //    [realm deleteAllObjects];
    
}


/**
 改
 */
- (void)r_update {
    RLMRealm *realm = [RLMRealm defaultRealm];
    // 获取需要更新数据的对象
    RLMResults *friends = [Friends objectsWhere:@"frendsId = %d",1];
    if (friends) {
        Friends *friend = friends.firstObject;
        // 更新数据，更新好友分组
        [realm transactionWithBlock:^{
            friend.groupId = 2;
        }];
    }
}

@end
