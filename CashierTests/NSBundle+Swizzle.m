//
//  NSBundle+Swizzle.m
//  Cashier
//
//  Created by Marius Constantinescu on 14/03/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

#import "NSBundle+Swizzle.h"

@implementation NSBundle (Swizzle)



- (id)szl_objectForInfoDictionaryKey:(NSString*)key {
    if ([key isEqualToString:@"CFBundleShortVersionString"]) {
        return @"0.0.2";
    } else {
        return [self szl_objectForInfoDictionaryKey:key];
    }
}


@end
