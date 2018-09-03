<p align="center">
  <img src="./Cashier_icon.png?raw=true" alt="Cashier"/>
</p>

Cashier is a caching framework that makes it easy to work with persistent data.

[![CircleCI](https://circleci.com/gh/nodes-ios/Cashier.svg?style=shield)](https://circleci.com/gh/nodes-ios/Cashier)
[![Codecov](https://img.shields.io/codecov/c/github/nodes-ios/Cashier.svg)](https://codecov.io/github/nodes-ios/Cashier)
[![CocoaPods](https://img.shields.io/cocoapods/v/Cashier.svg)](https://cocoapods.org/pods/Cashier)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Plaform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Codemine/blob/master/LICENSE)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=nodes-ios/cashier)](http://clayallsopp.github.io/readme-score?url=nodes-ios/cashier)

## 📝 Requirements

* iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
* Xcode 8.1+

## 📦 Installation

### Carthage
~~~
github "nodes-ios/Cashier"
~~~

### CocoaPods

~~~
pod 'Cashier', '~> 1.0.1'
~~~

## 💻 Usage
#### Creating and accessing a Cashier object
*Swift*
```swift
// Create a Cashier object with id "cacheID".
let cashier: Cashier = Cashier.cache(withId: "cacheID")

// Create a Cashier object the default cache.
let cashier: Cashier = Cashier.defaultCache()
```

*Objective-C*
```objective-c
// Create a Cashier object with id "cacheID".
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];

// Create a Cashier object the default cache.
Cashier* defaultCashier = Cashier.defaultCache;
```

The same method is used both for creating and accessing a Cashier object. If the Cashier object with the specified id hasn't been created before, it will be created and returned. If it has already been created, the existing one will be returned.

#### Caching NSString in a Cashier object
*Swift*
```swift
// Get or create a Cashier object with id "stringCache".
let cashier: Cashier = Cashier.cache(withId: "stringCache")

// Add an object to the cache.
cashier.setObject(stringToCache, forKey: "string")

// Get the object from the cache.
let cachedString: String = cashier.object(forKey: "string")
```

*Objective-C*
```objective-c
// Get or create a Cashier object with id "stringCache".
Cashier* cashier = [Cashier cacheWithId:@"stringCache"];

// Add an object to the cache.
[cashier setObject: stringToCache forKey:@"stringCacheKey"];

// Get the object from the cache.
NSString* stringFromCache = [cashier objectForKey: @"stringCacheKey"];
```

#### Caching NSData in a Cashier object
*Swift*
```swift
// Get or create a Cashier object with id "dataCache".
let cashier: Cashier = Cashier.cache(withId: "dataCache")

// Add an object to the cache.
cashier.setData(yourNSDataObject, forKey: "dataCacheKey")

// Get the object from the cache.
let cachedData = cashier.data(forKey: "dataCacheKey")
```

*Objective-C*
```objective-c
// Get or create a Cashier object with id "dataCache".
Cashier* cashier = [Cashier cacheWithId:@"dataCache"];

// Add an object to the cache.
[cashier setData: yourNSDataObject forKey:@"dataCacheKey"];

// Get the object from the cache.
NSData* dataFromCache = [cashier dataForKey:@"dataCacheKey"];
```

#### Caching UIImage in a Cashier object
*Swift*
```swift
// Get or create a Cashier object with id "imageCache".
let cashier: Cashier = Cashier.cache(withId: "imageCache")

// Add an object to the cache.
cashier.setImage(yourUIImage, forKey: "imageCacheKey")

// Get the object from the cache.
let imageFromCache: UIImage = cashier.image(forKey: "imageCacheKey")
```

*Objective-C*
```objective-c
// Get or create a Cashier object with id "imageCache".
Cashier* cashier = [Cashier cacheWithId:@"imageCache"];

// Add an object to the cache.
[cashier setImage: yourUIImage forKey:@"imageCacheKey"];

// Get the object from the cache.
UIImage* imageFromCache = [cashier imageForKey:@"imageCacheKey"];
```

#### Caching any other type of objects (including custom objects)
*Swift*
```swift
// Get or create a Cashier object with id "cacheID".
let cashier: Cashier = Cashier.cache(withId: "cacheID")

// Add an object to the cache.
let yourObject: YourObject = YourObject()
cashier.setObject(yourObject, forKey: "cacheKey")

// Get the object from the cache.
let objectFromCache: YourObject = cashier.object(forKey: "cacheKey")
```

*Objective-C*
```objective-c
// Get or create a Cashier object with id "cacheID".
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];

// Add an object to the cache.
YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"];

// Get the object from the cache.
YourObject* stringFromCache = [cashier objectForKey:@"cacheKey"];
```

You can get typed objects from the cache using the following methods:

*Swift*
```swift
- image(forKey: String)
- data(forKey: String)
- dictionary(forKey: String)
- array(forKey: String)
- string(forKey: String)
```

*Objective-C*
```objective-c
- (UIImage *)imageForKey:(NSString *)key;
- (NSData *)dataForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
```

#### Persistency

A cashier object has 2 layers of cache. If the `persistent` property is set to `NO`, the objects will be cached in memory, using an NSCache. If `persistent` is `YES`, the objects will be written to a file in the `Library/Caches` folder. This means that its contents are not backed up by iTunes and may be deleted by the system. Read more about the [iOS file system](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html).

*Swift*
```swift
// Get or create a Cashier object with id "cacheID".
let cashier: Cashier = Cashier.cache(withId: "cacheID")

// Makes the Cashier cache the objects in files.
cashier.persistent = true

// Makes the Cashier cache the objects in memory.
cashier.persistent = false
```

*Objective-C*

```objective-c
// Get or create a Cashier object with id "cacheID".
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];

// Makes the Cashier cache the objects in files.
cashier.persistent = YES;

// Makes the Cashier cache the objects in memory.
cashier.persistent = NO;
```

For persistent data that isn't saved in the `Library/Caches` folder, use the `NOPersistentStore`. This is a subclass of `Cashier`, that works exactly the same way as `Cashier`, but it saves its data to the `Documents/NOCache` folder, which isn't cleared by the system when the device runs out of space.

*Swift*
```swift
// Get or create a an NOPersistentStore object with id "noPersistentStoreId".
let noPersistentStore: NOPersistentStore = NOPersistentStore.cache(withId: "noPersistentStoreId")
```

*Objective-C*
```objective-c
// Get or create a an NOPersistentStore object with id "noPersistentStoreId".
NOPersistentStore* noPersistentStore = [NOPersistentStore cacheWithId:@"persistentStoreId"];
```

### Expiration

A `Cashier` object has a `lifespan`. This determine how long the cached objects should be valid before they're considered expired. If the cached objects are older than the cache’s lifespan, they will be considered expired. Expired objects are considered invalid, but they are not deleted. Set the `returnsExpiredData` to `YES` if you want to also use expired data. `lifespan` is 0 by default, which means that the data will never expire.

*Swift*
```swift
// Get or create a Cashier object with id "cacheID".
let cashier: Cashier = Cashier.cache(withId: "cacheID")

// Makes the cached objects have a lifespan of one minute.
cashier.lifespan = 60

// Makes the cache not return cached objects after their lifespan has passed.
cashier.returnsExpiredData = false

let yourObject: YourObject = YourObject()
cashier.setObject(yourObject, forKey: "cacheKey")

// After one minute passes.

cache.object(forKeyIsValid: "cacheKey")
// Returns: false

cache.object(forKey: "cacheKey")
// Returns: nil
```

```swift
// Get or create a Cashier object with id "cacheID".
let cashier: Cashier = Cashier.cache(withId: "cacheID")

// Makes the cached objects have a lifespan of one minute.
cashier.lifespan = 60

// Makes the cache return cached objects after their lifespan has passed.
cashier.returnsExpiredData = true

let yourObject: YourObject = YourObject()
cashier.setObject(yourObject, forKey: "cacheKey")

// After one minute passes.

cache.object(forKeyIsValid: "cacheKey")
// Returns: false

cache.object(forKey: "cacheKey")
// Returns: yourObject
```

*Objective-C*
```objective-c
// Get or create a Cashier object with id "cacheID".
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];

// Makes the cached objects have a lifespan of one minute.
cashier.lifespan = 60;

// Makes the cache not return cached objects after their lifespan has passed.
cashier.returnsExpiredData = NO;

YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"];

// After one minute passes.

[cashier objectForKeyIsValid:@"cacheKey"]
// Returns: NO

[cashier objectForKey:@"cacheKey"]
// Returns: nil
```

```objective-c
// Get or create a Cashier object with id "cacheID".
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];

// Makes the cached objects have a lifespan of one minute.
cashier.lifespan = 60;

//	Makes the cache return cached objects after their lifespan has passed.
cashier.returnsExpiredData = YES;

YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"];

// After one minute passes.

[cashier objectForKeyIsValid:@"cacheKey"]
// Returns: NO

[cashier objectForKey:@"cacheKey"]
// Returns: yourObject
```

It's possible to refresh the validation timestamp of an object using the `- (void)refreshValidationOnObjectForKey:(NSString *)key;` method. This will update the timestamp when the cached object was last validated to the current timestamp. This means that if an object had a lifespan of 1 minute, but then we refresh its validation, it will have a lifespan of 1 minute from the moment we refreshed its validation.

*Swift*
```swift
// Get or create a Cashier object with id "cacheID".
let cashier: Cashier = Cashier.cache(withId: "cacheID")

// Makes the cached objects have a lifespan of one minute.
cashier.lifespan = 60

let yourObject: YourObject = YourObject()
cashier.setObject(yourObject, forKey: "cacheKey")

// After 30 seconds passed

cache.refreshValidationOnObject(forKey: "cacheKey")

// After another 40 seconds passed.

cache.object(forKeyIsValid: "cacheKey")
// Returns: true
```

*Objective-C*
```objective-c
// Get or create a Cashier object with id "cacheID".
Cashier* cashier = [Cashier cacheWithId:@"cacheID"];

// Makes the cached objects have a lifespan of one minute.
cashier.lifespan = 60;

YourObject *yourObject = [[YourObject alloc] init];
[cashier setObject: yourObject forKey:@"cacheKey"];

// After 30 seconds passed

[cashier refreshValidationOnObjectForKey:@"cacheKey"];

// After another 40 seconds passed.

[cashier objectForKeyIsValid:@"cacheKey"]
// Returns: YES
```

The `persistsCacheAcrossVersions` property determines if the contents of the current cache persist across app version updates. `persistsCacheAcrossVersions` is `false` by default. This is because if a model changes, the app can crash if it gets old data from the cache and it’s expecting it to look differently.

### Security

The `encryptionEnabled` determines if the contents of the current cache are written to a protected file. If `encryptionEnabled` is false, the file that the cached objects are written to will be written using
[NSDataWritingFileProtectionComplete](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/index.html#//apple_ref/c/tdef/NSDataWritingOptions).
If `encryptionEnabled` is false, the file that the cached objects are written to will not be protected. `encryptionEnabled` is false by default.

### Usage guidelines

* We recommend using different caches for different types of data.
* Use the `Cashier.defaultCache` to get very easy access to a cache.
* We don't recommend using the default cache for storing lots of data (f.x., a data source of a table view), but for singular properties or objects. Also take into account the fact that the default cache doesn't persist across version updates.


## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**Cashier** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Cashier/blob/master/LICENSE) file for more info.
