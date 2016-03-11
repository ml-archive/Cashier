//
//  CashierTests.m
//  CashierTests
//
//  Created by Chris Combs on 09/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Cashier.h"

@interface CashierTests : XCTestCase

@end

@implementation CashierTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
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
    
    UIImage* imageToCache = [UIImage imageNamed:@"Nodes" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    XCTAssertNotNil(imageToCache);
    NSString* imageKey = @"imageKey";
    [cashier setImage:imageToCache forKey:imageKey];
    
    
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
    
    UIImage* noImageFromCache = [cashier objectForKey:imageKey];
    XCTAssertFalse([cashier objectForKeyIsValid:imageKey]);
    XCTAssertNil(noImageFromCache);

    
}

@end
