//
//  FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouter.h"
#import "FMRouterNode.h"
#import "NSString+FMRouter.h"
#import "NSArray+FMRouter.h"
#import "NSDictionary+FMRouter.h"

@interface FMRouter ()

@property (nonatomic) NSUInteger nodeLength;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSArray *nodes;
@property (nonatomic, strong) Class pageCls;

@end

@implementation FMRouter

- (instancetype) initWithPath:(NSString *)path {
    return [self initWithPath:path
                         page:nil];
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

- (NSDictionary *)allQueryForPath:(NSString *)relativePath {
    if (relativePath.isEmpty) {
        return nil;
    }
    NSString *queryString = [[relativePath componentsSeparatedByString:@"?"] lastObject];
    if (queryString.isEmpty) {
        return nil;
    }
    NSArray *queryItems = [queryString componentsSeparatedByString:@"&"];
    if (queryItems.isEmpty) {
        return nil;
    }
    NSMutableDictionary *querys = [NSMutableDictionary new];
    for (NSString *queryItem in queryItems) {
        NSArray *item = [queryItem componentsSeparatedByString:@"="];
        if (item.count == 2) {
            [querys setObject:item[1] forKey:item[0]];
        }
    }
    if (querys.isEmpty) {
        return nil;
    }
    return querys;
}

- (NSDictionary *)dynamicNodeForPath:(NSString *)relativePath {
    return [self dynamicNodeForPath:relativePath
                       removePrefix:nil];
}

- (NSDictionary *)dynamicNodeForPath:(NSString *)relativePath
                        removePrefix:(NSString *)prefix {
    FMRouter *router = [[[self class] alloc] initWithPath:relativePath];
    if (![self matchForRouter:router]) {
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

#pragma mark - the Methods that has hash Encode
- (NSUInteger) hash {
    if (self.nodes.count <= 0) {
        return [super hash];
    }
    NSInteger hashValue = [self.nodes[0] hash];
    for (NSInteger i = 1; i < [self.nodes count]; i++) {
        hashValue ^= [self.nodes[i] hash];
    }
    return hashValue;
}

- (BOOL) isEqual:(id)object {
    if (![object isKindOfClass:self.class]) {
        return NO;
    }
    return self.hash == [object hash];
}

- (BOOL) matchForRouter:(FMRouter *)router {
    if (router == nil || ![router isKindOfClass:self.class] || self.nodeLength != router.nodeLength) {
        return NO;
    }
    
    for (NSInteger i = 0; i < self.nodes.count; i++) {
        FMRouterNode *node = self.nodes[i];
        if (node.isDynamicNode) {
            continue;
        }
        if (![node match:router.nodes[i]]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) matchForPath:(NSString *)path {
    FMRouter *router = [[[self class] alloc] initWithPath:path];
    return [self matchForRouter:router];
}

- (BOOL) match:(FMRouter *)object {
    return [self matchForRouter:object];
}

@end
