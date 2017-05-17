//
//  FMRouterURL.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/9.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMRouterURL.h"
#import "NSString+FMRouter.h"
#import "NSArray+FMRouter.h"
#import "NSDictionary+FMRouter.h"

@interface FMRouterURL ()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *relativePath;
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
        self.relativePath = [self.url path];
    } else {
        self.relativePath = [[[self.url path] stringByAppendingString:@"?"] stringByAppendingString:self.url.query];
    }
    if ([self.relativePath hasPrefix:@"/"]) {
        self.relativePath = [self.relativePath substringFromIndex:1];
    }
}

- (NSURL *)urlWithUrlString:(NSString *)urlString {
    if ([urlString hasPrefix:@"file:"]) {
        return [NSURL fileURLWithPath:urlString];
    }
    return [NSURL URLWithString:urlString];
}

- (NSDictionary *)querys {
    if (self.url.query.isEmpty) {
        return nil;
    }
    
    NSArray *queryItems = [self.url.query componentsSeparatedByString:@"&"];
    if (queryItems.isEmpty) {
        return nil;
    }
    NSMutableDictionary *querys = [NSMutableDictionary new];
    for (NSString *queryItem in queryItems) {
        NSArray *item = [queryItem componentsSeparatedByString:@"="];
        if (item.count == 2) {
            [querys setObject:item[1] forKey:item[0]];
        }
    }
    if (querys.isEmpty) {
        return nil;
    }
    return querys;
}

- (NSString *) host {
    return self.url.host;
}

- (NSString *) scheme {
    return self.url.scheme;
}

@end
