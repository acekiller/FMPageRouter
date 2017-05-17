//
//  FMRouterSet.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouterSet.h"
#import "FMRouterMacro.h"

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

- (NSError *) addRouterForPathPattern:(NSString *)pathPattern
                                 page:(Class)pageCls {
    FMRouter *router = [[FMRouter alloc] initWithPath:pathPattern
                                                 page:pageCls];
    return [self addRouterForRouter:router];
}

- (NSError *) addRouterForRouter:(FMRouter *)router {
    if (router == nil) {
        return [NSError errorWithDomain:@"com.fantasy.FMPageRouter"
                                   code:FMPageRouterURLNoStaticNode
                               userInfo:@{NSLocalizedDescriptionKey:@"非法的,页面匹配路径，请检查匹配路径是否正确。"}];
    }
    
    if ([self hasConflictRouters:router]) {
        return [NSError errorWithDomain:@"com.fantasy.FMPageRouter"
                                   code:FMPageRouterURLConflict
                               userInfo:@{
                                          NSLocalizedDescriptionKey:@"匹配模式路径冲突。",
                                          @"pattern" : router.path
                                          }];
    }
    [routers addObject:router];
    return nil;
}

- (FMRouter *) routerForPath:(NSString *)path {
    FMRouter *router = [[FMRouter alloc] initWithPath:path];
    for (FMRouter *t_router in routers) {
        if ([t_router match:router]) {
            return t_router;
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
        if ([router matchForPath:path]) {
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
