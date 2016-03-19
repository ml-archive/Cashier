<p align="center">
  <img src="./Cashier_icon.png?raw=true" alt="Cashier"/>
</p>

Cashier is a caching framework that makes it easy to work with persistent data.

[![Build Status](https://travis-ci.org/nodes-ios/Cashier.svg?branch=master)](https://travis-ci.org/nodes-ios/Cashier)
[![Codecov](https://img.shields.io/codecov/c/github/nodes-ios/Cashier.svg)](https://codecov.io/github/nodes-ios/Cashier)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Plaform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Codemine/blob/master/LICENSE)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=nodes-ios/cashier)](http://clayallsopp.github.io/readme-score?url=nodes-ios/cashier)

## 📝 Requirements

* iOS 8.0+


## 📦 Installation

### Carthage
~~~
github "nodes-ios/Cashier"
~~~

### CocoaPods

CocoaPods support is coming soon.

## 💻 Usage
**Creating and accessing a Cashier object:**

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];             	// get/create a Cashier object with id "cacheID"
Cashier* defaultCashier = Cashier.defaultCache;						// get/create a the default cache.
```
The same method is used both for creating and accessing a Cashier object. If the Cashier object with the specified id hasn't been created before, it will be created and returned. If it has already been created, the existing one will be returned.

**Caching NSString in a Cashier object:**

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"stringCache"];             		// get/create a Cashier object with id "stringCache"
[cashier setObject: stringToCache forKey:@"stringCacheKey"];       			// add an object to the cache
NSString* stringFromCache = [cashier objectForKey: @"stringCacheKey"];   	// get the object from the cache
```

**Caching NSData in a Cashier object:**

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"dataCache"];             	// get/create a Cashier object with id "dataCache"
[cashier setData: yourNSDataObject forKey:@"dataCacheKey"];       	// add an object to the cache
NSData* dataFromCache = [cashier dataForKey:@"dataCacheKey"];   	// get the object from the cache
```

**Caching UIImage in a Cashier object:**

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"imageCache"];             // get/create a Cashier object with id "imageCache"
[cashier setImage: yourUIImage forKey:@"imageCacheKey"];       		// add an object to the cache
UIImage* imageFromCache = [cashier imageForKey:@"imageCacheKey"];   // get the object from the cache
```


**Caching any other type of objects (including custom objects)**

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];             	// get/create a Cashier object with id "cacheID"
YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"];       			// add an object to the cache
YourObject* stringFromCache = [cashier objectForKey:@"cacheKey"];   // get the object from the cache
```

You can get typed objects from the cache using the following methods:

```objective-c
- (UIImage *)imageForKey:(NSString *)key;
- (NSData *)dataForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
```

**Persistency**

A cashier object has 2 layers of cache. If the `persistent` property is set to `NO`, the objects will be cached in memory, using an NSCache. If `persistent` is `YES`, the objects will be written to a file in the `Library/Caches` folder. This means that its contents are not backed up by iTunes and may be deleted by the system. Read more about the [iOS file system](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html).

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];             	// get/create a Cashier object with id "cacheID"
cashier.persistent = YES;											// makes the Cashier cache the objects in files
cashier.persistent = NO;											// makes the Cashier cache the objects in memory
```

For persistent data that isn't saved in the `Library/Caches` folder, use the `NOPersistentStore`. This is a subclass of `Cashier`, that works exactly the same way as `Cashier`, but it saves its data to the `Documents/NOCache` folder, which isn't cleared by the system when the device runs out of space.

```objective-c
NOPersistentStore* persistentStore = [NOPersistentStore cacheWithId:@"persistentStoreId"];             	// get/create an NOPersistentStore object with id "persistentStoreId"
```

**Expiration**

A `Cashier` object has a `lifespan`. This determine how long the cached objects should be valid before they're considered expired. If the cached objects are older than the cache’s lifespan, they will be considered expired. Expired objects are considered invalid, but they are not deleted. Set the `returnsExpiredData` to `YES` if you want to also use expired data. `lifespan` is 0 by default, which means that the data will never expire.

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];    // get/create a Cashier object with id "cacheID"
cashier.lifespan = 60;									// makes the cached objects have a lifespan of one minute
cashier.returnsExpiredData = NO;						//	makes the cache not return cached objects after their lifespan has passed
YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"]; 
// after one minute
[cashier objectForKeyIsValid:@"cacheKey"]			// NO
[cashier objectForKey:@"cacheKey"]					// nil
```

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];    // get/create a Cashier object with id "cacheID"
cashier.lifespan = 60;									// makes the cached objects have a lifespan of one minute
cashier.returnsExpiredData = YES;						//	makes the cache return cached objects after their lifespan has passed
YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"]; 
// after one minute
[cashier objectForKeyIsValid:@"cacheKey"]			// NO
[cashier objectForKey:@"cacheKey"]					// yourObject
```

It's possible to refresh the validation timestamp of an object using the `- (void)refreshValidationOnObjectForKey:(NSString *)key;` method. This will update the timestamp when the cached object was last validated to the current timestamp. This means that if an object had a lifespan of 1 minute, but then we refresh its validation, it will have a lifespan of 1 minute from the moment we refreshed its validation.

```objective-c
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];    // get/create a Cashier object with id "cacheID"
cashier.lifespan = 60;									// makes the cached objects have a lifespan of one minute
YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"]; 
// after 30 seconds
[cashier refreshValidationOnObjectForKey:@"cacheKey"];
// after another 40 seconds
[cashier objectForKeyIsValid:@"cacheKey"]			// YES
```

The `persistsCacheAcrossVersions` property determines if the contents of the current cache persist across app version updates. `persistsCacheAcrossVersions` is `false` by default. This is because if a model changes, the app can crash if it gets old data from the cache and it’s expecting it to look differently.

**Security**

The `encryptionEnabled` determines if the contents of the current cache are written to a protected file. If `encryptionEnabled` is false, the file that the cached objects are written to will be written using 
[NSDataWritingFileProtectionComplete](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/index.html#//apple_ref/c/tdef/NSDataWritingOptions).
If `encryptionEnabled` is false, the file that the cached objects are written to will not be protected. `encryptionEnabled` is false by default.

**Usage guidelines**

* We recommend using different caches for different types of data. 
* Use the `Cashier.defaultCache` to get very easy access to a cache.
* We don't recommend using the default cache for storing lots of data (f.x., a data source of a table view), but for singular properties or objects. Also take into account the fact that the default cache doesn't persist across version updates.


## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**Cashier** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Cashier/blob/master/LICENSE) file for more info.
