//
//  NSObject+FMRouter.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FMRouter)
@property (nonatomic, readonly) NSDictionary *routerQuery;
@property (nonatomic, readonly) NSDictionary *routerExtParams;
@property (nonatomic, readonly) NSDictionary *routerDynamicNodes;
@property (nonatomic, readonly) NSDictionary *allRouterParams;
@property (nonatomic, weak, readonly) id passNode;
@end
