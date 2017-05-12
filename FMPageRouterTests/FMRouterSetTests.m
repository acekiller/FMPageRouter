//
//  FMRouterSetTests.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMRouterSet.h"

@interface FMRouterSetTests : XCTestCase

@end

@implementation FMRouterSetTests

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

- (void) testRouterSet {
    [[FMRouterSet routerSet] addRouterForPathPattern:@"api/string/:name" page:NSString.class];
    FMRouter *router = [[FMRouter alloc] initWithPath:@"api/object/:id" page:NSObject.class];
    [[FMRouterSet routerSet] addRouterForRouter:router];
    
    if ([[FMRouterSet routerSet] routerForPath:@"api/string/hello"].pageCls != NSString.class) {
        XCTFail(@"addRouterForPath test failed");
    }
    
    if ([[FMRouterSet routerSet] routerForPath:@"api/object/3e4f78aaceb"].pageCls != NSObject.class) {
        XCTFail(@"addRouterForRouter test failed");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
