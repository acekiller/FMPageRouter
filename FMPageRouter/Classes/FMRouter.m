//
//  FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouter.h"
#import "FMRouterNode.h"

@interface FMRouter ()

@property (nonatomic) NSUInteger nodeLength;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSArray *nodes;
@property (nonatomic, strong) Class pageCls;

- (BOOL) matchedForRouter:(FMRouter *)router;

@end

@implementation FMRouter

- (instancetype) initWithPath:(NSString *)path {
    return [self initWithPath:path page:nil];
}

- (instancetype) initWithPath:(NSString *)path
                         page:(Class)pageCls {
    self = [super init];
    if (self) {
        self.path = path;
        self.nodes = [self nodesForPath];
        self.nodeLength = [self.nodes count];
        if (self.nodeLength == 0 || [self isAllDynamicPath:self.nodes]) {
            return nil;
        }
        self.pageCls = pageCls;
    }
    return self;
}

- (NSArray *)nodesForPath {
    NSArray *nodeNames = [self nodeNamesForPath:self.path];
    NSMutableArray *nodes = [NSMutableArray new];
    for (NSUInteger i = 0; i < nodeNames.count; i++) {
        FMRouterNode *node = [FMRouterNode nodeWithName:nodeNames[i]
                                             nodeOffset:i];
        [nodes addObject:node];
    }
    return nodes;
}

- (BOOL) isAllDynamicPath:(NSArray *)nodes {
    for (FMRouterNode *node in nodes) {
        if (!node.isDynamicNode) {
            return NO;
        }
    }
    return YES;
}

- (NSArray *)nodeNamesForPath:(NSString *)path {
    [path stringByRemovingPercentEncoding];
    return [path componentsSeparatedByString:@"/"];
}

- (BOOL) matchedForRouter:(FMRouter *)router {
    if (router == nil || self.nodeLength != router.nodeLength) {
        return NO;
    }
    
    for (NSInteger i = 0; i < self.nodes.count; i++) {
        FMRouterNode *node = self.nodes[i];
        if (node.isDynamicNode) {
            continue;
        }
        if (![node.nodeName isEqual:[router.nodes[i] nodeName]]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) matchedForPath:(NSString *)path {
    FMRouter *router = [[[self class] alloc] initWithPath:path];
    return [self matchedForRouter:router];
}

- (NSDictionary *)dynamicNodeForPath:(NSString *)path {
    return [self dynamicNodeForPath:path
                 removePrefix:nil];
}

- (NSDictionary *)dynamicNodeForPath:(NSString *)path
                        removePrefix:(NSString *)prefix {
    FMRouter *router = [[[self class] alloc] initWithPath:path];
    if (![self matchedForRouter:router]) {
        return nil;
    }
    
    NSMutableDictionary *dynamicParams = [NSMutableDictionary new];
    for (FMRouterNode *node in self.nodes) {
        if (node.isDynamicNode) {
            if (prefix && [node.nodeName hasPrefix:prefix]) {
                [dynamicParams setObject:[router.nodes[node.nodeOffset] nodeName]
                                  forKey:[node.nodeName substringFromIndex:prefix.length]];
            } else {
                [dynamicParams setObject:[router.nodes[node.nodeOffset] nodeName]
                                  forKey:node.nodeName];
            }
        }
    }
    return dynamicParams;
}

/*
 *  当router长度相同时，相同偏移位的node属性均相同时(同nodeName／同动态/一个动态一个静态时，其静态nodeName均相同)。
 *  具体判断而言，需要存在相同的nodeOffset位置，当前Router的节点和给定router的节点，均不为动态检查节点，且不相等时，两个router不冲突，否则两个router冲突。
 */
- (BOOL) isConflictRouter:(FMRouter *)router {
    if (router.nodeLength != self.nodeLength) {
        return NO;
    }
    
    for (FMRouterNode *node in self.nodes) {
        FMRouterNode *otherNode = router.nodes[node.nodeOffset];
        if (!node.isDynamicNode && ![otherNode isDynamicNode] && ![node.nodeName isEqualToString:otherNode.nodeName]) {
            return NO;
        }
    }
    return YES;
}

@end
