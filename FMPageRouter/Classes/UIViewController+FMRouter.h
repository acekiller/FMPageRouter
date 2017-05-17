//
//  UIViewController+FMRouter.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMPageRouter.h"

@interface UIViewController (FMRouter)

////仅单路由匹配模式支持,当+ (NSString *) routerPath 配置的routerPath不为空时，+ (NSArray *) routerPaths的配置将不会生效。
//+ (NSString *) routerPathPattern;
//
////包含多路由匹配支持
//+ (NSArray *) routerPathPatterns;
////路由方式传入的参数值获取

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath;

- (UIViewController *) routerWithURLString:(NSString *)urlString;

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath
                                     passNode:(id)passNode;

- (UIViewController *) routerWithURLString:(NSString *)urlString
                                  passNode:(id)passNode;

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath
                                     passNode:(id)passNode
                                       isPush:(BOOL)isPush;

- (UIViewController *) routerWithURLString:(NSString *)urlString
                                  passNode:(id)passNode
                                    isPush:(BOOL)isPush;

- (UIViewController *) routerWithRelativePath:(NSString *)relativePath
                                     passNode:(id)passNode
                                   transition:(id)transition
                                    extParams:(NSDictionary *)extParams
                                       isPush:(BOOL)isPush;

- (UIViewController *) routerWithURLString:(NSString *)urlString
                                  passNode:(id)passNode
                                transition:(id)transition
                                 extParams:(NSDictionary *)extParams
                                    isPush:(BOOL)isPush;


@end
