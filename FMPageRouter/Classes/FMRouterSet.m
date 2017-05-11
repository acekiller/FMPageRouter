//
//  FMRouterSet.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouterSet.h"

#define FMPageRouterNULLError 10000
#define FMPageRouterConflictError 10001

@implementation FMRouterSet {
    NSMutableArray *routers;
}

+ (instancetype) routerSet {
    static id instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
    
}

- (instancetype) init {
    self = [super init];
    if (self) {
        routers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSError *) addRouterForPath:(NSString *)path
                          page:(Class)pageCls {
    FMRouter *router = [[FMRouter alloc] initWithPath:path page:pageCls];
    return [self addRouterForRouter:router];
}

- (NSError *) addRouterForRouter:(FMRouter *)router {
    if (router == nil) {
        return [NSError errorWithDomain:@"com.fantasy.FMPageRouter"
                                   code:FMPageRouterNULLError
                               userInfo:@{NSLocalizedDescriptionKey:@"非法的,页面匹配路径，请检查匹配路径是否正确。"}];
    }
    
    if ([self hasConflictRouters:router]) {
        return [NSError errorWithDomain:@"com.fantasy.FMPageRouter"
                                   code:FMPageRouterConflictError
                               userInfo:@{NSLocalizedDescriptionKey:@"已存在相同匹配规则的路径，请确保匹配路径的唯一性。"}];
    }
    [routers addObject:router];
    return nil;
}

- (FMRouter *) routerForPath:(NSString *)path {
    for (FMRouter *router in routers) {
        if ([router matchedForPath:path]) {
            return router;
        }
    }
    return nil;
}

- (NSDictionary *) dynamicNodesForPath:(NSString *)path {
    FMRouter *matchedRouter = [self searchRouterForPath:path];
    if (matchedRouter == nil) {
        return nil;
    }
    return [matchedRouter dynamicNodeForPath:path];
}

- (FMRouter *)searchRouterForPath:(NSString *)path {
    for (FMRouter *router in routers) {
        if ([router matchedForPath:path]) {
            return router;
        }
    }
    return nil;
}

- (BOOL) hasConflictRouters:(FMRouter *)router {
    for (FMRouter *tmp_router in routers) {
        if ([tmp_router isConflictRouter:router]) {
            return YES;
        }
    }
    return NO;
}

@end
