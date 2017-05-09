//
//  FMRouterNode.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMRouterNode : NSObject

@property (nonatomic,readonly) NSString *nodeName;
@property (nonatomic, readonly) NSUInteger nodeOffset;
@property (nonatomic, readonly) BOOL isDynamicNode;

+ (void) addDynamicNodePattern:(NSString *)pattern;
+ (NSArray *) dynamicNodePatterns;

+ (instancetype) nodeWithName:(NSString *)nodeName
                   nodeOffset:(NSUInteger)nodeOffset;

- (instancetype) init NS_UNAVAILABLE;

- (BOOL) matchForNodeName:(NSString *)nodeName;

@end
