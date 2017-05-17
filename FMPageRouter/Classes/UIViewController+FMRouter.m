//
//  UIViewController+FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "UIViewController+FMRouter.h"

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

//+ (NSString *) routerPathPattern {
//    return nil;
//}
//
////包含多路由匹配支持
//+ (NSArray *) routerPathPatterns {
//    return nil;
//}

//+ (void) registerRouterForPaths:(NSArray *)paths {
//    if (paths.isEmpty) {
//        return;
//    }
//    for (NSString *path in paths) {
//        [FMPageRouter registerPageControllerClass:self
//                                forRouterPathPattern:path];
//    }
//}

#pragma mark - Controller Router Method

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath {
    return [self routerWithRelativePath:relativePath
                               passNode:nil];
}

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath
                                     passNode:(id)passNode {
    return [self routerWithRelativePath:relativePath
                               passNode:passNode
                                 isPush:YES];
}

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath
                                     passNode:(id)passNode
                                       isPush:(BOOL)isPush {
    return [self routerWithRelativePath:relativePath
                               passNode:passNode
                             transition:nil
                              extParams:nil
                                 isPush:isPush];
}

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath
                                     passNode:(id)passNode
                                   transition:(id)transition
                                    extParams:(NSDictionary *)extParams
                                       isPush:(BOOL)isPush {
    return [[FMPageRouter shareInstance] routerPageWithRelativePath:relativePath
                                                          extParams:extParams
                                                             target:self
                                                         transition:transition
                                                             isPush:isPush
                                                           passNode:passNode
                                                             failed:^(NSError *error) {
                                                                 //
                                                             }];
}

- (UIViewController *) routerWithURLString:(NSString *)urlString {
    return [self routerWithURLString:urlString passNode:nil];
}

- (UIViewController *) routerWithURLString:(NSString *)urlString
                    passNode:(id)passNode {
    return [self routerWithURLString:urlString
                            passNode:passNode
                              isPush:YES];
}

- (UIViewController *) routerWithURLString:(NSString *)urlString
                                  passNode:(id)passNode
                                    isPush:(BOOL)isPush {
    return [self routerWithURLString:urlString
                            passNode:passNode
                          transition:nil
                           extParams:nil
                              isPush:isPush];
}

- (UIViewController *) routerWithURLString:(NSString *)urlString
                                  passNode:(id)passNode
                                transition:(id)transition
                                 extParams:(NSDictionary *)extParams
                                    isPush:(BOOL)isPush {
    return [[FMPageRouter shareInstance] routerPageWithURL:urlString
                                                 extParams:extParams
                                                    target:self
                                                transition:transition
                                                    isPush:isPush
                                                  passNode:passNode
                                                    failed:^(NSError *error) {
                                                        //
                                                    }];
}

@end
