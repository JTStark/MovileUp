//
//  FavoritesManager.swift
//  MovileUp15-07
//
//  Created by iOS on 7/28/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import Foundation

class FavoritesManager {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    private let FavoritesKey = "favorites"
    static let favoritesChangedNotificationName = "the favorites were changed"
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    var favoritesIdentifiers: Set<Int> {
        let favs = defaults.objectForKey(FavoritesKey) as? [Int] ?? []
        return Set(favs)
    }
    
    deinit {
        println("\(self.dynamicType) deinit")
    }
    
    func addIdentifier(identifier: Int) {
        var ids = favoritesIdentifiers
        ids.insert(identifier)
        defaults.setObject(Array(ids), forKey: FavoritesKey)
        defaults.synchronize()
        notificationCenter.postNotificationName(self.dynamicType.favoritesChangedNotificationName, object: self)
    }
    
    func removeIdentifier(identifier: Int) {
        var ids = favoritesIdentifiers
        ids.remove(identifier)
        defaults.setObject(Array(ids), forKey: FavoritesKey)
        defaults.synchronize()
        notificationCenter.postNotificationName(self.dynamicType.favoritesChangedNotificationName, object: self)
    }
}