//
//  FMRouterURL.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouterURL.h"

@interface FMRouterURL ()
@property (nonatomic, strong) NSURL *url;
@end

@implementation FMRouterURL

- (instancetype) initWithUrlString:(NSString *)urlString {
    return [self initWithUrl:[self urlWithUrlString:urlString]];
}

- (instancetype) initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
        [self _initParamsFormatter];
    }
    return self;
}

- (void) _initParamsFormatter {
    if (self.url.query.length <= 0) {
        self.path = [self.url path];
    } else {
        self.path = [[[self.url path] stringByAppendingString:@"?"] stringByAppendingString:self.url.query];
    }
}

- (NSURL *)urlWithUrlString:(NSString *)urlString {
    if ([urlString hasPrefix:@"file:"]) {
        return [NSURL fileURLWithPath:urlString];
    }
    return [NSURL URLWithString:urlString];
}

@end
