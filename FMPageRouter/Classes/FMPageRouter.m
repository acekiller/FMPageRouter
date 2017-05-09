//
//  FMPageRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMPageRouter.h"
#import "FMRouterSet.h"

@implementation FMPageRouter

+ (void) addSupportRouterDomain:(NSString *)domain forScheme:(NSString *)scheme {
//    TODO
}

+ (BOOL) isSupportRouterWithUrlString:(NSString *)urlString {
//    TODO
    return YES;
}

+ (BOOL) isSupportRouterWithUrl:(NSURL *)url {
//    TODO
    return YES;
}

+ (void) addDynamicNodePattern:(NSString *)pattern {
    [FMRouterNode addDynamicNodePattern:pattern];
}

+ (NSArray *)dynamicNodePatterns {
    return [FMRouterNode dynamicNodePatterns];
}

+ (instancetype) shareInstance {
    static id obj;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        obj = [[self class] alloc];
    });
    return obj;
}

+ (void) registerPageControllerClass:(Class)controllerClass
                   forRouterPagePath:(NSString *)path {
    [[self shareInstance] registerPageControllerClass:controllerClass
                                    forRouterPagePath:path];
}

- (void) registerPageControllerClass:(Class)controllerClass
                   forRouterPagePath:(NSString *)path {
//    TODO
}

+ (Class) getRequestClassWithURL:(NSString *)routerURL
                       extParams:(NSDictionary *)extParams
                          failed:(void(^)(NSError *))failed {
//    TODO
    return nil;
}

+ (UIViewController *) requestPageWithURL:(NSString *)routerURL
                                extParams:(NSDictionary *)extParams //用于扩展routerURL的数据
                                   failed:(void(^)(NSError *))failed {
//    TODO :
    return nil;
}

/*此方法采用默认push动画方案*/
+ (UIViewController *)routerPageWithURL:(NSString *)routerURL
                              extParams:(NSDictionary *)extParams
                                 target:(UIViewController *)target
                                 failed:(void(^)(NSError *))failed {
    return [self routerPageWithURL:routerURL
                         extParams:extParams
                        target:target
                        transition:nil
                            isPush:YES
                            failed:failed];
}

+ (UIViewController *)routerPageWithURL:(NSString *)routerURL
                              extParams:(NSDictionary *)extParams
                                 target:(UIViewController *)target
                             transition:(id)transition
                                 isPush:(BOOL)isPush
                                 failed:(void (^)(NSError *))failed {
//    XXX :
    UIViewController *controller = [self requestPageWithURL:routerURL
                                                  extParams:extParams
                                                     failed:^(NSError *error) {
                                                         if (failed) {
                                                             failed(error);
                                                         };
                                                     }];
    if (transition) {
        //
    }
    if (isPush && target.navigationController != nil) {
        [target.navigationController pushViewController:controller
                                                   animated:YES];
    } else {
        [target presentViewController:controller
                             animated:YES
                           completion:^{
                               //
                           }];
    }
    
    return controller;
}

@end
