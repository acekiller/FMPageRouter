//
//  NSString+FMRouter.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/2.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "NSString+FMRouter.h"

@implementation NSString (FMRouter)

- (BOOL) isEmpty {
    if (![self isKindOfClass:NSString.class]) {
        return YES;
    }
    if ([(NSString *)self length] <= 0) {
        return YES;
    }
    return NO;
}

@end
