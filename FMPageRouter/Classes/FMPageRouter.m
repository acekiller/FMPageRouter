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

#import "FMRouterMacro.h"

#import "FMRouterSet.h"
#import "FMRouterURL.h"

const NSString *routerDynamicNodeParamsKey;
const NSString *routerQueryParamsKey;
const NSString *routerAllParamsKey;
const NSString *routerExtParamsKey;
const NSString *routerPassNodeKey;

@interface FMPageRouter () {
    NSString *_appScheme;
    NSString *_appDomain;
}
@property (nonatomic, strong) FMRouterSet *routerSet;
@end

@implementation FMPageRouter

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
        NSDictionary *userInfo = [[NSBundle mainBundle] infoDictionary];
        _appScheme = userInfo[(NSString *)kCFBundleExecutableKey];
        _appDomain = userInfo[(NSString *)kCFBundleIdentifierKey];
        self.routerSet = [FMRouterSet routerSet];
        [self addSupportRouterDomain:_appDomain forScheme:_appScheme];
    }
    return self;
}

- (void) addSupportRouterDomain:(NSString *)domain forScheme:(NSString *)scheme {
//    TODO
}

//+ (BOOL) isSupportRouterWithUrlString:(NSString *)urlString {
////    TODO
//    return YES;
//}

- (BOOL) isSupportRouterWithUrl:(FMRouterURL *)url {
//    TODO
    return YES;
}

- (NSString *)appDomain {
    return _appDomain;
}

- (NSString *)appScheme {
    return _appScheme;
}

- (NSString *)appRouterHost {
    return [[_appScheme stringByAppendingString:@"://"] stringByAppendingString:_appDomain];
}

- (NSString *)appPathWithRelativePath:(NSString *)relativePath {
    if ([relativePath hasPrefix:@"/"]) {
        return [[self appRouterHost] stringByAppendingString:relativePath];
    }
    return [[[self appRouterHost] stringByAppendingString:@"/"] stringByAppendingString:relativePath];
}

+ (void) registerPageControllerClass:(Class)controllerClass
                forRouterPathPattern:(NSString *)pathPattern {
    [[self shareInstance] registerPageControllerClass:controllerClass
                                 forRouterPathPattern:pathPattern];
}

- (void) registerPageControllerClass:(Class)controllerClass
                forRouterPathPattern:(NSString *)pathPattern {
    if (![controllerClass isSubclassOfClass:UIViewController.class]) {
        return;
    }
    [self.routerSet addRouterForPathPattern:pathPattern
                                       page:controllerClass];
}

- (Class) getRequestClassWithURL:(NSString *)routerURL
                       extParams:(NSDictionary *)extParams
                          failed:(void(^)(NSError *))failed {
    FMRouterURL *url = [[FMRouterURL alloc] initWithUrlString:routerURL];
    if ([[self class] isSupportRouterWithUrl:url]) {
        return nil;
    }
    FMRouter *router = [[FMPageRouter shareInstance].routerSet routerForPath:url.relativePath];
    return router.pageCls;
}

- (UIViewController *) requestPageWithURL:(NSString *)routerURL
                                extParams:(NSDictionary *)extParams //用于扩展routerURL的数据
                                 passNode:(id)passNode
                                   failed:(void(^)(NSError *))failed {
    FMRouterURL *url = [[FMRouterURL alloc] initWithUrlString:routerURL];
    if ([[self class] isSupportRouterWithUrl:url]) {
        failed([NSError errorWithDomain:@"com.fantasy.FMPageRouter"
                                   code:FMPageRouterURLIllegal
                               userInfo:@{
                                          NSLocalizedDescriptionKey : @"非法的请求链接。",
                                          @"url": routerURL
                                          }]);
        return nil;
    }
    FMRouter *router = [[FMPageRouter shareInstance].routerSet routerForPath:url.relativePath];
    if (router == nil) {
        failed([NSError errorWithDomain:@"com.fantasy.FMPageRouter"
                                   code:FMPageRouterURLMatchPagFailed
                               userInfo:@{NSLocalizedDescriptionKey:@"无匹配的页面", @"url": routerURL}]);
        return nil;
    }
    UIViewController *controller = [[router.pageCls alloc] init];
    [self bindDynamicNode:[router dynamicNodeForPath:url.relativePath]
                   querys:[router allQueryForPath:url.relativePath]
                      ext:extParams
                 passNode:passNode
             toController:controller];
    return controller;
}

- (void) bindDynamicNode:(NSDictionary *)dynamicNode
                  querys:(NSDictionary *)querys
                     ext:(NSDictionary *)ext
                passNode:(id)passNode
            toController:(UIViewController *)controller {
    if (passNode) {
        objc_setAssociatedObject(controller, &routerPassNodeKey, passNode, OBJC_ASSOCIATION_ASSIGN);
    }
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
- (UIViewController *)routerPageWithRelativePath:(NSString *)relativePath
                                       extParams:(NSDictionary *)extParams
                                          target:(UIViewController *)target
                                          failed:(void(^)(NSError *))failed {
    return [self routerPageWithRelativePath:relativePath
                                  extParams:extParams
                                     target:target
                                 transition:nil
                                     isPush:YES
                                     failed:failed];
}

/*暂时未实现自定义专场动画功能，接口仅为预留*/
- (UIViewController *)routerPageWithRelativePath:(NSString *)relativePath
                                       extParams:(NSDictionary *)extParams
                                          target:(UIViewController *)target
                                      transition:(id)transition
                                          isPush:(BOOL)isPush
                                          failed:(void(^)(NSError *))failed {
    return [self routerPageWithRelativePath:relativePath
                                  extParams:extParams
                                     target:target
                                 transition:transition
                                     isPush:isPush
                                     passNode:nil
                                     failed:failed];
}

/*暂时未实现自定义专场动画功能，接口仅为预留*/
- (UIViewController *)routerPageWithRelativePath:(NSString *)relativePath
                                       extParams:(NSDictionary *)extParams
                                          target:(UIViewController *)target
                                      transition:(id)transition
                                          isPush:(BOOL)isPush
                                        passNode:(id)passNode
                                          failed:(void(^)(NSError *))failed {
    return [self routerPageWithURL:[self appPathWithRelativePath:relativePath]
                         extParams:extParams
                            target:target
                        transition:transition
                            isPush:isPush
                          passNode:passNode
                            failed:failed];
}

- (UIViewController *) requestPageWithURL:(NSString *)routerURL
                                extParams:(NSDictionary *)extParams
                                   failed:(void (^)(NSError *))failed {
    return [self requestPageWithURL:routerURL
                          extParams:extParams
                           passNode:nil
                             failed:failed];
}

/*此方法采用默认push动画方案*/
- (UIViewController *)routerPageWithURL:(NSString *)routerURL
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

- (UIViewController *)routerPageWithURL:(NSString *)routerURL
                              extParams:(NSDictionary *)extParams
                                 target:(UIViewController *)target
                             transition:(id)transition
                                 isPush:(BOOL)isPush
                                 failed:(void (^)(NSError *))failed {
    return [self routerPageWithURL:routerURL
                         extParams:extParams
                            target:target
                        transition:transition
                            isPush:isPush
                          passNode:nil
                            failed:failed];
}

- (UIViewController *) routerPageWithURL:(NSString *)routerURL
                               extParams:(NSDictionary *)extParams
                                  target:(UIViewController *)target
                              transition:(id)transition
                                  isPush:(BOOL)isPush
                                passNode:(id)passNode
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

- (id)passNodeForController:(UIViewController *)controller {
    return objc_getAssociatedObject(controller, &routerPassNodeKey);
}

@end
