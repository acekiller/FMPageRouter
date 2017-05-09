//
//  FMRouterNode.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouterNode.h"
static NSMutableSet *patterns;

@implementation FMRouterNode

+ (void) addDynamicNodePattern:(NSString *)pattern {
    if (patterns == nil) {
        patterns = [NSMutableSet new];
    }
    [patterns addObject:pattern];
}

+ (NSArray *)dynamicNodePatterns {
    return patterns.allObjects;
}

- (instancetype) initWithNodeName:(NSString *)nodeName
                       nodeOffset:(NSUInteger)nodeOffset {
    self = [super init];
    if (self) {
        _nodeName = [nodeName copy];
        _nodeOffset = nodeOffset;
        [self updateNodeData];
    }
    return self;
}

+ (instancetype) nodeWithName:(NSString *)nodeName
                   nodeOffset:(NSUInteger)nodeOffset {
    return [[self alloc] initWithNodeName:nodeName
                               nodeOffset:nodeOffset];
}

- (void) updateNodeData {
    _isDynamicNode = [self dynamicNodeAdapterForNodeName:self.nodeName inPatterns:[self.class dynamicNodePatterns]];
}

- (BOOL) matchForNodeName:(NSString *)nodeName {
    if (_isDynamicNode) {
        return YES;
    }
    if ([nodeName isEqualToString:self.nodeName]) {
        return YES;
    }
    return NO;
}

- (NSUInteger) hash {
    return [self.nodeName hash];
}

- (BOOL) isEqual:(id)object {
    if ([object isKindOfClass:self.class]) {
        return NO;
    }
    return [super isEqual:object];
}

- (BOOL) dynamicNodeAdapterForNodeName:(NSString *)nodeName
                            inPatterns:(NSArray *)patterns {
    for (NSString *pattern in patterns) {
        if (![pattern isKindOfClass:NSString.class] || pattern == nil || pattern.length <= 0) {
            continue;
        }
        
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:nil];
        NSRange firstMatch = [regExp rangeOfFirstMatchInString:nodeName
                                                       options:NSMatchingReportProgress
                                                         range:[nodeName rangeOfString:nodeName]];
        if (firstMatch.location != NSNotFound && firstMatch.length == nodeName.length) {
            return YES;
        }
    }
    return NO;
}

@end
