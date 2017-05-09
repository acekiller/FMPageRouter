//
//  FMRouterURL.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMRouterURL : NSObject
@property (nonatomic, strong) NSString *path;

- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithUrlString:(NSString *)urlString;

- (instancetype) initWithUrl:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end
