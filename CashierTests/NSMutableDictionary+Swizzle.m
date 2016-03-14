//
//  NSMutableDictionary+Swizzle.m
//  Cashier
//
//  Created by Marius Constantinescu on 14/03/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

#import "NSMutableDictionary+Swizzle.h"

@implementation NSMutableDictionary (Swizzle)

- (id)szl_objectForKey:(id)key {
    if ([key isKindOfClass:[NSString class]] && [key isEqualToString:@"szl_cacheID2"]) {
        return nil;
    } else {
        return [self szl_objectForKey:key];
    }
}
@end
