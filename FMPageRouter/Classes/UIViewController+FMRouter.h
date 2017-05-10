//
//  UIViewController+FMRouter.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FMRouter)

@property (nonatomic, readonly) NSDictionary *routerQuery;
@property (nonatomic, readonly) NSDictionary *routerExtParams;
@property (nonatomic, readonly) NSDictionary *routerDynamicNodes;
@property (nonatomic, readonly) NSDictionary *allRouterParams;

//仅单路由匹配模式支持,当+ (NSString *) routerPath 配置的routerPath不为空时，+ (NSArray *) routerPaths的配置将不会生效。
+ (NSString *) routerPathPattern;

//包含多路由匹配支持
+ (NSArray *) routerPathPatterns;
//路由方式传入的参数值获取

@end
