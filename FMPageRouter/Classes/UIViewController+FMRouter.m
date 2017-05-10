//
//  UIViewController+FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "UIViewController+FMRouter.h"
#import "FMPageRouter.h"

@implementation UIViewController (FMRouter)

//+ (void)load {
//    NSLog(@"%@:%s",self,__PRETTY_FUNCTION__);
//    [self loadRouters];
//}
//
//+ (void) loadRouters {
//    NSMutableArray *routerPaths = [NSMutableArray new];
//    NSString *sigPath = [self routerPath];
//    NSArray *multiPaths = [self routerPaths];
//    if (sigPath.isEmpty) {
//        if (multiPaths.isEmpty) {
//            return;
//        }
//        [routerPaths addObjectsFromArray:multiPaths];
//    } else {
//        [routerPaths addObject:sigPath];
//    }
//    
//    [self registerRouterForPaths:routerPaths];
//}

+ (NSString *) routerPathPattern {
    return nil;
}

//包含多路由匹配支持
+ (NSArray *) routerPathPatterns {
    return nil;
}

+ (void) registerRouterForPaths:(NSArray *)paths {
    if (paths.isEmpty) {
        return;
    }
    for (NSString *path in paths) {
        [FMPageRouter registerPageControllerClass:self
                                forRouterPagePath:path];
    }
}

- (NSDictionary *)routerQuery {
    return [[FMPageRouter shareInstance] routerQueryParamsForController:self];
}

- (NSDictionary *)routerDynamicNodes {
    return [[FMPageRouter shareInstance] routerDynamicNodeParamsForController:self];
}

- (NSDictionary *)routerExtParams {
    return [[FMPageRouter shareInstance] routerExtParamsForController:self];
}

- (NSDictionary *)allRouterParams {
    return [[FMPageRouter shareInstance] routerAllParamsForController:self];
}

@end
