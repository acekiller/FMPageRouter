//
//  FMRouterTests.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMRouter.h"

@interface FMRouterTests : XCTestCase

@end

@implementation FMRouterTests

- (void)setUp {
    [super setUp];
    [FMRouterNode addDynamicNodePattern:@":[\%\\w]+"];
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

- (void) testRouter {
    FMRouter *router1 = [[FMRouter alloc] initWithPath:@"api/:aps" page:FMRouter.class];
    FMRouter *router2 = [[FMRouter alloc] initWithPath:@"api/:aps/avi" page:FMRouter.class];
    FMRouter *router3 = [[FMRouter alloc] initWithPath:@"api/:acc" page:FMRouter.class];
    
    NSLog(@"router1 dyn : %@", [router1 dynamicNodeForPath:@"api/hello"]);
    
    if ([router2 dynamicNodeForPath:@"api/achd/avi" removePrefix:@":"].count != 1) {
        XCTFail("dynamicNodeForPath test Failed");
    }
    
    if ([router2 allQueryForPath:@"api/apst/avi?id=01935&name=feng&type=2"].count != 3) {
        XCTFail("api/apst/avi?id=01935&name=feng&type=2 Querys Test Failed");
    }
    
    if (![router1 matchedForPath:@"api/welcome"]) {
        XCTFail("api/welcome not matched");
    }
    
    if ([router1 matchedForPath:@"api/welcome/amc"]) {
        XCTFail("api/welcome/amc error matched");
    }
    
    if (![router2 matchedForPath:@"api/welcome/avi"]) {
        XCTFail("api/welcome/amc not matched");
    }
    
    if ([router2 matchedForPath:@"api/welcome"]) {
        XCTFail("api/welcome error matched");
    }
    
    if ([router1 isConflictRouter:router2]) {
        XCTFail("for router1 and router2 conflict check has bug");
    }
    
    if (![router1 isConflictRouter:router3]) {
        XCTFail("for router1 and router3 conflict check has bug");
    }
    
    if ([router2 isConflictRouter:router3]) {
        XCTFail("for router2 and router3 conflict check has bug");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
