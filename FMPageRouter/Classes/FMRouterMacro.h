//
//  FMRouterMacro.h
//  FMPageRouter
//
//  Created by Fantasy on 2017/5/12.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FMPageRouterURLNoStaticNode 10000
#define FMPageRouterURLConflict 10001
#define FMPageRouterURLIllegal 10002
#define FMPageRouterURLMatchPagFailed 10003
#define FMPageRouterURLIsNotViewController 10004

#define NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define NSUINTROTATE(val, howmuch) ((((NSUInteger)(val)) << (howmuch)) | (((NSUInteger)(val)) >> (NSUINT_BIT - (howmuch))))

# define ROTATEHASH(A,B) (NSUINTROTATE(A,NSUINT_BIT / 2)^(B))
