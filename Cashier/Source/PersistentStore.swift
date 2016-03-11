//
//  PersistentStore.swift
//  Cashier
//
//  Created by Chris Combs on 20/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

public class PersistentStore: Cashier {
	
	private static let persistentKey = "INTERNAL_PERSISTENT_DEFAULT_CACHE"
	
	public var baseSaveDirectory: String {
		//TODO: Not sure how safe this is, maybe need fallback if array is empty
		let directories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
		let directory = directories[0] as NSString
		return directory.stringByAppendingPathComponent("Cashier")
	}
	
	public func fileURLWillBeWritten(url: NSURL) throws {
		//FIXME: Why do we do this? Shouldn't persistent data be backed up?
		try url.setResourceValue(true, forKey: NSURLIsExcludedFromBackupKey)
	}
	
	//FIXME: fix method signature when NOCache gets rewritten to Swift
	public override static func defaultCache() -> PersistentStore {
		return PersistentStore.cacheWithId(persistentKey)
	}
	
	//FIXME: fix this when NOCache gets rewritten to Swift
	@nonobjc public override var persistsCacheAcrossVersions: Bool {
		get { return true }
		set {}
	}
}

