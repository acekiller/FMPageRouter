//
//  FMRouterNodeTests.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMRouterNode.h"

@interface FMRouterNodeTests : XCTestCase

@end

@implementation FMRouterNodeTests

- (void)setUp {
    [super setUp];
    NSLog(@"%s",__PRETTY_FUNCTION__);
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

- (void) testPatternMatch {
    FMRouterNode *node = [FMRouterNode nodeWithName:@":acd01a_" nodeOffset:0];
    if (!node.isDynamicNode) {
        XCTFail("node Dynamic Test Failed");
    }
    
    FMRouterNode *errorNode = [FMRouterNode nodeWithName:@"f:acef" nodeOffset:0];
    if (errorNode.isDynamicNode) {
        XCTFail("errorNode Dynamic Test Failed");
    }
    
    FMRouterNode *nodeChinese = [FMRouterNode nodeWithName:@":acd01a_" nodeOffset:0];
    if (!nodeChinese.isDynamicNode) {
        XCTFail("nodeChinese Dynamic Test Failed");
    }
    
    FMRouterNode *nodeStatic = [FMRouterNode nodeWithName:@"index" nodeOffset:0];
    if (nodeStatic.isDynamicNode) {
        XCTFail("nodeChinese Dynamic Test Failed");
    }
}

- (void) testMatchString {
    FMRouterNode *node = [FMRouterNode nodeWithName:@"index" nodeOffset:0];
    if (![node matchForNodeName:@"index"]) {
        XCTFail("index test failed");
    }
    
    if ([node matchForNodeName:@"api"]) {
        XCTFail("api test failed");
    }
    
    FMRouterNode *dynamicNode = [FMRouterNode nodeWithName:@":index" nodeOffset:0];
    if (![dynamicNode matchForNodeName:@"afcc"]) {
        XCTFail("index test failed");
    }
    
    if (![dynamicNode matchForNodeName:@"mftt"]) {
        XCTFail("mftt test failed");
    }
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
