//
//  FMPageRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMPageRouter.h"

#import <objc/runtime.h>

#import "NSDictionary+FMRouter.h"

#import "FMRouterSet.h"
#import "FMRouterURL.h"

const NSString *routerDynamicNodeParamsKey;
const NSString *routerQueryParamsKey;
const NSString *routerAllParamsKey;
const NSString *routerExtParamsKey;

@interface FMPageRouter ()
@property (nonatomic, strong) FMRouterSet *routerSet;
@end

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

- (instancetype) init {
    self = [super init];
    if (self) {
        self.routerSet = [FMRouterSet routerSet];
    }
    return self;
}

+ (void) registerPageControllerClass:(Class)controllerClass
                   forRouterPagePath:(NSString *)relativePath {
    [[self shareInstance] registerPageControllerClass:controllerClass
                                    forRouterPagePath:relativePath];
}

- (void) registerPageControllerClass:(Class)controllerClass
                   forRouterPagePath:(NSString *)path {
    if (![controllerClass isSubclassOfClass:UIViewController.class]) {
        return;
    }
    [self.routerSet addRouterForPath:path page:controllerClass];
}

+ (Class) getRequestClassWithURL:(NSString *)routerURL
                       extParams:(NSDictionary *)extParams
                          failed:(void(^)(NSError *))failed {
    FMRouterURL *url = [[FMRouterURL alloc] initWithUrlString:routerURL];
    FMRouter *router = [[FMPageRouter shareInstance].routerSet routerForPath:url.relativePath];
    return router.pageCls;
}

+ (UIViewController *) requestPageWithURL:(NSString *)routerURL
                                extParams:(NSDictionary *)extParams //用于扩展routerURL的数据
                                   failed:(void(^)(NSError *))failed {
    FMRouterURL *url = [[FMRouterURL alloc] initWithUrlString:routerURL];
    FMRouter *router = [[FMPageRouter shareInstance].routerSet routerForPath:url.relativePath];
    
    UIViewController *controller = [[router.pageCls alloc] init];
    [self bindDynamicNode:[router dynamicNodeForPath:url.relativePath]
                   querys:[router allQueryForPath:url.relativePath]
                      ext:extParams
             toController:controller];
    return controller;
}

+ (void) bindDynamicNode:(NSDictionary *)dynamicNode querys:(NSDictionary *)querys ext:(NSDictionary *)ext toController:(UIViewController *)controller {
    objc_setAssociatedObject(controller, &routerDynamicNodeParamsKey, dynamicNode, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(controller, &routerQueryParamsKey, querys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(controller, &routerExtParamsKey, ext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableDictionary *allParams = [NSMutableDictionary new];
    if (![dynamicNode isEmpty]) {
        [allParams addEntriesFromDictionary:dynamicNode];
    }
    
    if (![querys isEmpty]) {
        [allParams addEntriesFromDictionary:querys];
    }
    
    if (![ext isEmpty]) {
        [allParams addEntriesFromDictionary:ext];
    }
    
    objc_setAssociatedObject(controller, &routerAllParamsKey, allParams.isEmpty ? nil : allParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (NSDictionary *)routerDynamicNodeParamsForController:(UIViewController *)controller {
    return objc_getAssociatedObject(controller, &routerDynamicNodeParamsKey);
}

- (NSDictionary *)routerQueryParamsForController:(UIViewController *)controller {
    return objc_getAssociatedObject(controller, &routerDynamicNodeParamsKey);
}

- (NSDictionary *)routerExtParamsForController:(UIViewController *)controller {
    return objc_getAssociatedObject(controller, &routerDynamicNodeParamsKey);
}

- (NSDictionary *)routerAllParamsForController:(UIViewController *)controller {
    return objc_getAssociatedObject(controller, &routerDynamicNodeParamsKey);
}

@end
