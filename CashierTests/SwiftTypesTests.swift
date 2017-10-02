//
//  SwiftTypesTests.swift
//  Cashier
//
//  Created by Marius Constantinescu on 22/01/2017.
//  Copyright © 2017 Nodes. All rights reserved.
//

import XCTest
import Cashier
import UIKit

class SwiftTypesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStoringSwiftTypesInDefaultCache() {
        let cache : Cashier! = Cashier.cache(withId: "bestCacheId")
        
        let double : Double = 2.0
        cache.setObject(double, forKey: "double")
        if let cachedDouble = cache.object(forKey: "double") as? Double {
            XCTAssert(cachedDouble == double)
        } else {
            XCTFail()
        }
        
        let int : Int = 2
        cache.setObject(int, forKey: "int")
        if let cachedInt = cache.object(forKey: "int") as? Int {
            XCTAssert(cachedInt == int)
        } else {
            XCTFail()
        }
        
        let float : Float = 2.0
        cache.setObject(float, forKey: "float")
        if let cachedFloat = cache.object(forKey: "float") as? Float {
            XCTAssert(cachedFloat == float)
        } else {
            XCTFail()
        }
        
        let bool : Bool = true
        cache.setObject(bool, forKey: "bool")
        if let cachedBool = cache.object(forKey: "bool") as? Bool {
            XCTAssert(cachedBool == bool)
        } else {
            XCTFail()
        }
        
        let string : String = "a string"
        cache.setObject(string, forKey: "string")
        if let cachedString = cache.object(forKey: "string") as? String {
            XCTAssert(cachedString == string)
        } else {
            XCTFail()
        }
        
        let doubleArray : [Double] = [2.0, 3.0]
        cache.setObject(doubleArray, forKey: "doubleArray")
        if let cachedDoubleArray = cache.object(forKey: "doubleArray") as? [Double] {
            XCTAssert(cachedDoubleArray == doubleArray)
        } else {
            XCTFail()
        }
        
        let intArray : [Int] = [2, 3]
        cache.setObject(intArray, forKey: "intArray")
        if let cachedIntArray = cache.object(forKey: "intArray") as? [Int] {
            XCTAssert(cachedIntArray == intArray)
        } else {
            XCTFail()
        }
        
        let floatArray : [Float] = [2.0, 3.0]
        cache.setObject(floatArray, forKey: "floatArray")
        if let cachedFloatArray = cache.object(forKey: "floatArray") as? [Float] {
            XCTAssert(cachedFloatArray == floatArray)
        } else {
            XCTFail()
        }
        
        let boolArray : [Bool] = [true, false]
        cache.setObject(boolArray, forKey: "boolArray")
        if let cachedBoolArray = cache.object(forKey: "boolArray") as? [Bool] {
            XCTAssert(cachedBoolArray == boolArray)
        } else {
            XCTFail()
        }
        
        let stringArray : [String] = ["a string", "another string"]
        cache.setObject(stringArray, forKey: "stringArray")
        if let cachedStringArray = cache.object(forKey: "stringArray") as? [String] {
            XCTAssert(cachedStringArray == stringArray)
        } else {
            XCTFail()
        }
        
        let song = Song(id: 14, name: "name", artist: "artist", album: "album", duration: 184)
        cache.setObject(song, forKey: "song")
        if let cachedSong = cache.object(forKey: "song") as? Song {
            XCTAssert(cachedSong == song)
        } else {
            XCTFail()
        }
        
        let image : UIImage! = UIImage(named: "Nodes", in: Bundle(for: type(of: self)), compatibleWith: nil)
        cache.setImage(image, forKey: "image")
        if let cachedImage = cache.image(forKey: "image") {
            XCTAssert(cachedImage == image)
        } else {
            XCTFail()
        }
        
        let data : Data! = string.data(using: .utf8)
        cache.setData(data, forKey: "data")
        if let cachedData = cache.data(forKey: "data") {
            XCTAssert(cachedData == data)
        } else {
            XCTFail()
        }
    }
    
    func testStoringSwiftTypesInPersistentStore() {
        let cache : NOPersistentStore! = NOPersistentStore.cache(withId: "bestPersistentStoreId")
        
        let double : Double = 2.0
        cache.setObject(double, forKey: "double")
        if let cachedDouble = cache.object(forKey: "double") as? Double {
            XCTAssert(cachedDouble == double)
        } else {
            XCTFail()
        }
        
        let int : Int = 2
        cache.setObject(int, forKey: "int")
        if let cachedInt = cache.object(forKey: "int") as? Int {
            XCTAssert(cachedInt == int)
        } else {
            XCTFail()
        }
        
        let float : Float = 2.0
        cache.setObject(float, forKey: "float")
        if let cachedFloat = cache.object(forKey: "float") as? Float {
            XCTAssert(cachedFloat == float)
        } else {
            XCTFail()
        }
        
        let bool : Bool = true
        cache.setObject(bool, forKey: "bool")
        if let cachedBool = cache.object(forKey: "bool") as? Bool {
            XCTAssert(cachedBool == bool)
        } else {
            XCTFail()
        }
        
        let string : String = "a string"
        cache.setObject(string, forKey: "string")
        if let cachedString = cache.object(forKey: "string") as? String {
            XCTAssert(cachedString == string)
        } else {
            XCTFail()
        }
        
        let doubleArray : [Double] = [2.0, 3.0]
        cache.setObject(doubleArray, forKey: "doubleArray")
        if let cachedDoubleArray = cache.object(forKey: "doubleArray") as? [Double] {
            XCTAssert(cachedDoubleArray == doubleArray)
        } else {
            XCTFail()
        }
        
        let intArray : [Int] = [2, 3]
        cache.setObject(intArray, forKey: "intArray")
        if let cachedIntArray = cache.object(forKey: "intArray") as? [Int] {
            XCTAssert(cachedIntArray == intArray)
        } else {
            XCTFail()
        }
        
        let floatArray : [Float] = [2.0, 3.0]
        cache.setObject(floatArray, forKey: "floatArray")
        if let cachedFloatArray = cache.object(forKey: "floatArray") as? [Float] {
            XCTAssert(cachedFloatArray == floatArray)
        } else {
            XCTFail()
        }
        
        let boolArray : [Bool] = [true, false]
        cache.setObject(boolArray, forKey: "boolArray")
        if let cachedBoolArray = cache.object(forKey: "boolArray") as? [Bool] {
            XCTAssert(cachedBoolArray == boolArray)
        } else {
            XCTFail()
        }
        
        let stringArray : [String] = ["a string", "another string"]
        cache.setObject(stringArray, forKey: "stringArray")
        if let cachedStringArray = cache.object(forKey: "stringArray") as? [String] {
            XCTAssert(cachedStringArray == stringArray)
        } else {
            XCTFail()
        }
        
        let song = Song(id: 14, name: "name", artist: "artist", album: "album", duration: 184)
        cache.setObject(song, forKey: "song")
        if let cachedSong = cache.object(forKey: "song") as? Song {
            XCTAssert(cachedSong == song)
        } else {
            XCTFail()
        }
        
        let image : UIImage! = UIImage(named: "Nodes", in: Bundle(for: type(of: self)), compatibleWith: nil)
        cache.setImage(image, forKey: "image")
        if let cachedImage = cache.image(forKey: "image") {
            XCTAssert(cachedImage == image)
        } else {
            XCTFail()
        }
        
        let data : Data! = string.data(using: .utf8)
        cache.setData(data, forKey: "data")
        if let cachedData = cache.data(forKey: "data") {
            XCTAssert(cachedData == data)
        } else {
            XCTFail()
        }
    }
    
}
