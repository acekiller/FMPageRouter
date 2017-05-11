//
//  FMRouterURLTests.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMRouterURL.h"

@interface FMRouterURLTests : XCTestCase

@end

@implementation FMRouterURLTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void) testUrlPathCheck {
    FMRouterURL *urlParams = [[FMRouterURL alloc] initWithUrlString:@"https://gotoappbox.com/api/v2/:deviceid?id=welcome&name=names"];
    NSLog(@"urlParams : %@",urlParams.relativePath);
    
    FMRouterURL *urlParams1 = [[FMRouterURL alloc] initWithUrlString:@"https://gotoappbox.com/api/v2/dddd?id=welcome&name=names"];
    NSLog(@"urlParams : %@",urlParams1.relativePath);
    
    FMRouterURL *url = [[FMRouterURL alloc] initWithUrlString:@"https://gotoappbox.com/api/v2/:deviceid"];
    NSLog(@"url : %@",url.relativePath);
    
    FMRouterURL *customerUrl = [[FMRouterURL alloc] initWithUrlString:@"FMPageRouter://test/api/v/de"];
    NSLog(@"customerUrl : %@",customerUrl.relativePath);
    
//    FMRouterURL *
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
