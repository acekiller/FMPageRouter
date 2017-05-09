//
//  FMRouter.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMRouterNode.h"

@interface FMRouter : NSObject

@property (nonatomic, readonly) NSUInteger nodeLength;
@property (nonatomic, readonly) NSString *path;
@property (nonatomic, readonly) NSArray *nodes;
@property (nonatomic, readonly) Class pageCls;

/*
 * 禁止直接调用init方法
 */
- (instancetype) init NS_UNAVAILABLE;

/*
 *  当Path的URL路径长度解析为0时,将返回null
 */
- (instancetype) initWithPath:(NSString *)path
                         page:(Class)pageCls NS_DESIGNATED_INITIALIZER;

- (instancetype) initWithPath:(NSString *)path;

//判断给定的路径是否与当前路由匹配
- (BOOL) matchedForPath:(NSString *)path;

/*
 * 用于检查给定的路由是否与其存在路由检测冲突
 */
- (BOOL) isConflictRouter:(FMRouter *)router;

- (NSDictionary *)dynamicNodeForPath:(NSString *)path;

- (NSDictionary *)dynamicNodeForPath:(NSString *)path
                        removePrefix:(NSString *)prefix;

@end
