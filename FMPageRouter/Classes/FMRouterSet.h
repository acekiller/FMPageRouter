//
//  FMRouterSet.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/8.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMRouter.h"

@interface FMRouterSet : NSObject

+ (instancetype) routerSet;

- (instancetype) init NS_UNAVAILABLE;

- (NSError *) addRouterForPathPattern:(NSString *)pathPattern
                                 page:(Class)pageCls;

- (NSError *) addRouterForRouter:(FMRouter *)router;

- (FMRouter *) routerForPath:(NSString *)path;

- (NSDictionary *) dynamicNodesForPath:(NSString *)path;

@end
