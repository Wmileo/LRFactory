//
//  SimpleViewTests.m
//  SimpleViewTests
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SimpleViewTests : XCTestCase

@end

@implementation SimpleViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSUInteger i0 = 0;
    NSUInteger i1 = 1 << 0;
    NSUInteger i2 = 1 << 1;
    NSUInteger i4 = 1 << 2;
    
    NSUInteger ii = i0 | i1 | i2 | i4;
    
    NSLog(@"%zd",ii);
    
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
