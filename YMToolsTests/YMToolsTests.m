//
//  YMToolsTests.m
//  YMToolsTests
//
//  Created by longxian on 2018/5/14.
//  Copyright © 2018年 YM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface YMToolsTests : XCTestCase
/** viewC */
@property (nonatomic, strong) ViewController *viewC;
@end

@implementation YMToolsTests

// 初始化代码，在测试方法调用之前调用
- (void)setUp {
    [super setUp];
    self.viewC = [[ViewController alloc] init];
}

// 每个测试用例执行后都会调用
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.viewC = nil;
    [super tearDown];
}

// 测试用例的例子
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int result = [self.viewC getMaxNumber:100];
    XCTAssertEqual(result, 100, @"测试不通过");
}

// 测试性能例子
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
