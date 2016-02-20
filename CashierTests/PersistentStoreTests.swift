//
//  PersistentStoreTests.swift
//  Cashier
//
//  Created by Chris Combs on 20/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest
import Cashier

class PersistentStoreTests: XCTestCase {

	var persistentStore: PersistentStore!
	
    override func setUp() {
        super.setUp()
        persistentStore = PersistentStore.defaultCache()
    }
	
	func testDefaultCache() {
		XCTAssertNotNil(persistentStore, "Failed to create default cache")
		let directory: String = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("Cashier")
		XCTAssertEqual(persistentStore.baseSaveDirectory, directory, "Failed to create base save directory")
	}
	
	func testfileURL() {
		//TODO: find a way to easily test this
	}
	
	
	
	func testPersists() {
		XCTAssertTrue(persistentStore.persistsCacheAcrossVersions, "Failed to set persistsCacheAcrossVersions to true")
		persistentStore.persistsCacheAcrossVersions = false
		XCTAssertTrue(persistentStore.persistsCacheAcrossVersions, "Failed to ignore setter for persistsCacheAcrossVersions")
	}
}
