//
//  NSMutableDictionary+Swizzle.h
//  Cashier
//
//  Created by Marius Constantinescu on 14/03/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Swizzle)

- (id)szl_objectForKey:(NSString*)key;
@end
