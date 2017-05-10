//
//  NSDictionary+FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/10.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "NSDictionary+FMRouter.h"

@implementation NSDictionary (FMRouter)
- (BOOL) isEmpty
{
    if (![self isKindOfClass:NSDictionary.class]) {
        return YES;
    }
    if ([self count] <= 0) {
        return YES;
    }
    return NO;
}
@end
