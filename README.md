# Cashier

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

### Swit Package Manager

SPM support is coming soon.

**NOTE:** This doesn't currently work as SPM doesn't support iOS, but once it will we will already be supporting it! :)


## 💻 Usage

```objective-c
Cashier* cashier =[Cashier cacheWithId:@"cacheID"];             // get/create a Cashier object with id cacheID
[cashier setObject: stringToCache forKey:@"stringCache"];       // add an object to the cache
NSString* stringFromCache = [cashier objectForKey:stringKey];   // get the object from the cache
```
// TODO: add more usage examples

## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**Cashier** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Cashier/blob/master/LICENSE) file for more info.
