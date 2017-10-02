//
//  CashierTests.m
//  CashierTests
//
//  Created by Chris Combs on 09/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Cashier.h"
#import <objc/runtime.h>
#import "NSBundle+Swizzle.h"
#import "NSMutableDictionary+Swizzle.h"

@interface CashierTests : XCTestCase

@end

@implementation CashierTests

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [[NSBundle mainBundle] class];
        
        SEL originalSelector = @selector(objectForInfoDictionaryKey:);
        SEL swizzledSelector = @selector(szl_objectForInfoDictionaryKey:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        
        
        
        Class class2 = [[[NSMutableDictionary alloc] init] class];
        
        SEL originalSelector2 = @selector(objectForKey:);
        SEL swizzledSelector2 = @selector(szl_objectForKey:);
        
        Method originalMethod2 = class_getInstanceMethod(class2, originalSelector2);
        Method swizzledMethod2 = class_getInstanceMethod(class2, swizzledSelector2);
        
        BOOL didAddMethod2 =
        class_addMethod(class2,
                        originalSelector2,
                        method_getImplementation(swizzledMethod2),
                        method_getTypeEncoding(swizzledMethod2));
        
        if (didAddMethod2) {
            class_replaceMethod(class2,
                                swizzledSelector2,
                                method_getImplementation(originalMethod2),
                                method_getTypeEncoding(originalMethod2));
        } else {
            method_exchangeImplementations(originalMethod2, swizzledMethod2);
        }
    });

}



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectCachingInDefaultCache {
    Cashier* cashier = Cashier.defaultCache;
    
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    
    [cashier setObject: stringToCache forKey:stringKey];
    NSString* stringFromCache = [cashier objectForKey:stringKey];
    
    XCTAssertEqual(stringFromCache, stringToCache);
    
    NSString* sameStringFromCache = [cashier stringForKey:stringKey];
    XCTAssertEqual(sameStringFromCache, stringToCache);
    
    [cashier deleteObjectForKey:stringKey];
    NSString* noStringFromCache = [cashier objectForKey:stringKey];
    XCTAssertNil(noStringFromCache);
    
    NSDictionary* dictToCache = [[NSDictionary alloc] initWithObjects:@[@"obj"] forKeys:@[@"key"]];
    NSString* dictKey = @"dictkey";
    
    [cashier setObject: dictToCache forKey:dictKey];
    NSDictionary* dictFromCache = [cashier objectForKey:dictKey];
    
    XCTAssertEqual(dictToCache, dictFromCache);
    
    NSDictionary* sameDictFromCache = [cashier dictForKey:dictKey];
    XCTAssertEqual(dictToCache, sameDictFromCache);
    
    NSDictionary* againSameDictFromCache = [cashier dictionaryForKey:dictKey];
    XCTAssertEqual(dictToCache, againSameDictFromCache);
    
    [cashier deleteObjectForKey:dictKey];
    NSDictionary* noDictFromCache = [cashier objectForKey:dictKey];
    XCTAssertNil(noDictFromCache);
    
    NSData* dataToCache = [[NSData alloc] initWithBase64EncodedString:stringToCache options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString* dataKey = @"dataKey";
    
    [cashier setObject:dataToCache forKey:dataKey];
    NSData* dataFromCache = [cashier objectForKey:dataKey];
    
    XCTAssertEqual(dataToCache, dataFromCache);
    
    NSData* sameDataFromCache = [cashier dataForKey:dataKey];
    XCTAssertEqual(dataToCache, sameDataFromCache);
    
    [cashier deleteObjectForKey:dataKey];
    NSData* noDataFromCache = [cashier objectForKey:dataKey];
    XCTAssertNil(noDataFromCache);
    
    NSArray* arrayToCache = [[NSArray alloc] initWithObjects:@"this", @"will", @"be", @"cached", nil];
    NSString* arrayKey = @"arrayKey";
    
    [cashier setObject:arrayToCache forKey:arrayKey];
    NSArray* arrayFromCache = [cashier objectForKey:arrayKey];
    
    XCTAssertEqual(arrayToCache, arrayFromCache);
    
    NSArray* sameArrayFromCache = [cashier arrayForKey:arrayKey];
    XCTAssertEqual(arrayToCache, sameArrayFromCache);
    
    [cashier deleteObjectForKey:arrayKey];
    NSArray* noArrayFromCache = [cashier objectForKey:arrayKey];
    XCTAssertNil(noArrayFromCache);
#if TARGET_OS_IPHONE
    UIImage* imageToCache = [UIImage imageNamed:@"Nodes" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    XCTAssertNotNil(imageToCache);
    NSString* imageKey = @"imageKey";
    
    [cashier setImage:imageToCache forKey:imageKey];
    UIImage* imageFromCache = [cashier objectForKey:imageKey];
    
    XCTAssertEqual(imageToCache, imageFromCache);
    
    UIImage* sameImageFromCache = [cashier imageForKey:imageKey];
    XCTAssertEqual(imageToCache, sameImageFromCache);
    
    [cashier deleteObjectForKey:imageKey];
    UIImage* noImageFromCache = [cashier objectForKey:imageKey];
    XCTAssertNil(noImageFromCache);
#endif
    
}

- (void)testCacheClearingInDefaultCache {
    Cashier* cashier = Cashier.defaultCache;
    
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    
    
    NSDictionary* dictToCache = [[NSDictionary alloc] initWithObjects:@[@"obj"] forKeys:@[@"key"]];
    NSString* dictKey = @"dictkey";
    [cashier setObject: dictToCache forKey:dictKey];
    
    NSData* dataToCache = [[NSData alloc] initWithBase64EncodedString:stringToCache options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString* dataKey = @"dataKey";
    [cashier setObject:dataToCache forKey:dataKey];
    
    NSArray* arrayToCache = [[NSArray alloc] initWithObjects:@"this", @"will", @"be", @"cached", nil];
    NSString* arrayKey = @"arrayKey";
    [cashier setObject:arrayToCache forKey:arrayKey];
#if TARGET_OS_IPHONE
    UIImage* imageToCache = [UIImage imageNamed:@"Nodes" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    XCTAssertNotNil(imageToCache);
    NSString* imageKey = @"imageKey";
    [cashier setImage:imageToCache forKey:imageKey];
#endif
    
    [cashier clearAllData];
    
    NSString* noStringFromCache = [cashier objectForKey:stringKey];
    XCTAssertFalse([cashier objectForKeyIsValid:stringKey]);
    XCTAssertNil(noStringFromCache);
    
    
    NSDictionary* noDictFromCache = [cashier objectForKey:dictKey];
    XCTAssertFalse([cashier objectForKeyIsValid:dictKey]);
    XCTAssertNil(noDictFromCache);

    
    NSData* noDataFromCache = [cashier objectForKey:dataKey];
    XCTAssertFalse([cashier objectForKeyIsValid:dataKey]);
    XCTAssertNil(noDataFromCache);
    
    
    NSArray* noArrayFromCache = [cashier objectForKey:arrayKey];
    XCTAssertFalse([cashier objectForKeyIsValid:arrayKey]);
    XCTAssertNil(noArrayFromCache);
    
#if TARGET_OS_IPHONE
    UIImage* noImageFromCache = [cashier objectForKey:imageKey];
    XCTAssertFalse([cashier objectForKeyIsValid:imageKey]);
    XCTAssertNil(noImageFromCache);
#endif
    
}

- (void)testCacheLifespanObjectExpired {
    Cashier* cashier = Cashier.defaultCache;
    cashier.lifespan = 0.5;
    cashier.returnsExpiredData = YES;
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    NSString* stringFromCache = [cashier objectForKey:stringKey];
    XCTAssertEqual(stringFromCache, stringToCache);
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"expecting cached string object to be invalid"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertFalse([cashier objectForKeyIsValid:stringKey]);
        XCTAssertNotNil([cashier objectForKey:stringKey]);
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:1 handler:nil];
    
}

- (void)testCacheLifespanObjectBecomesNil {
    Cashier* cashier = Cashier.defaultCache;
    cashier.lifespan = 0.5;
    cashier.returnsExpiredData = NO;
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    NSString* stringFromCache = [cashier objectForKey:stringKey];
    XCTAssertEqual(stringFromCache, stringToCache);
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"expecting cached string object to be invalid"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertFalse([cashier objectForKeyIsValid:stringKey]);
        XCTAssertNil([cashier objectForKey:stringKey]);
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:1 handler:nil];
    
}
#if TARGET_OS_IPHONE
- (void)testMemoryCacheClearsOnMemoryWarning {
    Cashier* cashier = Cashier.defaultCache;
    cashier.persistent = NO;
    
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    NSString* stringFromCache = [cashier objectForKey:stringKey];
    XCTAssertEqual(stringFromCache, stringToCache);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    XCTAssertNil([cashier objectForKey:stringKey]);
    
}
#endif

- (void)testCachePersistsOnVersionUpdates {
    NSString* cacheID = @"szl_cacheID1";
    Cashier* cashier = [Cashier cacheWithId:cacheID];
    cashier.persistsCacheAcrossVersions = YES;
    
    
    
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"0.0.1" forKey:[@"NOCACHE_VER_" stringByAppendingString:cacheID]];
    [userDefaults synchronize];
    
    Cashier* cashier2 = [Cashier cacheWithId:cacheID];
    
    NSString* stringFromCache = [cashier2 objectForKey:stringKey];
    
    XCTAssertEqual(stringFromCache, stringToCache);
    XCTAssertNotNil([cashier2 objectForKey:stringKey]);
    
}


- (void)testCacheDoesNotPersistOnVersionUpdates {
    NSString* cacheID = @"szl_cacheID2";
    
    Cashier* cashier = [Cashier cacheWithId:cacheID];
    cashier.persistsCacheAcrossVersions = NO;
    
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"0.0.1" forKey:[@"NOCACHE_VER_" stringByAppendingString:cacheID]];
    [userDefaults synchronize];
    
    Cashier* cashier2 = [Cashier cacheWithId:cacheID];
    
    NSString* stringFromCache = [cashier2 objectForKey:stringKey];
    
    XCTAssertFalse([cashier2 objectForKeyIsValid:stringKey], @"Object is valid even though it shouldn't be in a new version.");
    XCTAssertNil(stringFromCache);
}


- (void)testCacheActuallySavesOnDisk {
    Cashier* cashier = Cashier.defaultCache;
    // forcing cache to write to files
    cashier.persistent = YES;
    
    NSString* stringToCache = @"this will be cached";
    NSString* stringKey = @"stringkey";
    [cashier setObject: stringToCache forKey:stringKey];
    NSString* stringFromCache = [cashier objectForKey:stringKey];
    XCTAssertEqual(stringFromCache, stringToCache);
#if TARGET_OS_IPHONE
    // forcing cache to clear memory cache
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
#endif
    XCTAssertNotNil([cashier objectForKey:stringKey]);
    XCTAssertTrue([stringToCache isEqualToString:[cashier objectForKey:stringKey]]);
    
}

@end
