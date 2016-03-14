//
//  NSBundle+Swizzle.h
//  Cashier
//
//  Created by Marius Constantinescu on 14/03/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Swizzle)

- (id)szl_objectForInfoDictionaryKey:(NSString*)key;

@end
