//
//  NSArray+FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "NSArray+FMRouter.h"

@implementation NSArray (FMRouter)

- (BOOL) isEmpty
{
    if (![self isKindOfClass:NSArray.class]) {
        return YES;
    }
    if ([(NSArray *)self count] <= 0) {
        return YES;
    }
    return NO;
}

@end
