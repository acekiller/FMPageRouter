//
//  NSObject+FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "NSObject+FMRouter.h"
#import "FMPageRouter.h"

@implementation NSObject (FMRouter)

- (NSDictionary *)routerQuery {
    return [[FMPageRouter shareInstance] routerQueryParamsForObject:self];
}

- (NSDictionary *)routerDynamicNodes {
    return [[FMPageRouter shareInstance] routerDynamicNodeParamsForObject:self];
}

- (NSDictionary *)routerExtParams {
    return [[FMPageRouter shareInstance] routerExtParamsForObject:self];
}

- (NSDictionary *)allRouterParams {
    return [[FMPageRouter shareInstance] routerAllParamsForObject:self];
}

- (id) passNode {
    return [[FMPageRouter shareInstance] passNodeForObject:self];
}

@end
