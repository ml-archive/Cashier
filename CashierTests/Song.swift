//
//  Song.swift
//  Cashier
//
//  Created by Marius Constantinescu on 22/01/2017.
//  Copyright © 2017 Nodes. All rights reserved.
//

import Foundation

struct Song : Equatable {
    var id = 0
    var name = ""
    var artist = ""
    var album = ""
    var duration : TimeInterval = 0
    
    public static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.artist == rhs.artist && lhs.album == rhs.album && lhs.duration == rhs.duration
    }
}
