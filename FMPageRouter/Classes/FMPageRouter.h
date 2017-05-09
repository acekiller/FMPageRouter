//
//  FMPageRouter.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMRouterExtensions.h"

@interface FMPageRouter : NSObject

+ (void) addSupportRouterDomain:(NSString *)domain forScheme:(NSString *)scheme;

+ (BOOL) isSupportRouterWithUrlString:(NSString *)urlString;

+ (BOOL) isSupportRouterWithUrl:(NSURL *)url;

+ (void) addDynamicNodePattern:(NSString *)pattern;

+ (NSArray *) dynamicNodePatterns;

+ (void) registerPageControllerClass:(Class)controllerClass
                   forRouterPagePath:(NSString *)path;

+ (Class) getRequestClassWithURL:(NSString *)routerURL
                       extParams:(NSDictionary *)extParams
                          failed:(void(^)(NSError *))failed;

+ (UIViewController *) requestPageWithURL:(NSString *)routerURL
                                 extParams:(NSDictionary *)extParams //用于扩展routerURL的数据
                                   failed:(void(^)(NSError *))failed;

/*此方法采用默认push动画方案*/
+ (UIViewController *)routerPageWithURL:(NSString *)routerURL
                              extParams:(NSDictionary *)extParams
                                 target:(UIViewController *)target
                                 failed:(void(^)(NSError *))failed;

/*暂时未实现自定义专场动画功能，接口仅为预留*/
+ (UIViewController *)routerPageWithURL:(NSString *)routerURL
                              extParams:(NSDictionary *)extParams
                                 target:(UIViewController *)target
                             transition:(id)transition
                                 isPush:(BOOL)isPush
                                 failed:(void(^)(NSError *))failed;


@end
