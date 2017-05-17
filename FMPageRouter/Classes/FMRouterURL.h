//
//  FMRouterURL.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMRouterURL : NSObject
@property (nonatomic, readonly) NSString *scheme;
@property (nonatomic, readonly) NSString *host;
@property (nonatomic, readonly) NSString *relativePath;
@property (nonatomic, readonly) NSDictionary *querys;

- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithUrlString:(NSString *)urlString;

- (instancetype) initWithUrl:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end
