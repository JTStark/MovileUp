//
//  Episode.swift
//  MovileUp15-07
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import Foundation

struct OldEpisode {
    let number: Int
    let name: String
    
    static func allEpisodes() -> [OldEpisode] {
        let eps = [(1, "Pilot"),
                   (2, "Honor Thy Father"),
                   (3, "Lone Gunmen"),
                   (4, "An Innocent Man"),
                   (5, "Damaged"),
                   (6, "Legacies"),
                   (7, "Muse of Fire"),
                   (8, "Vendetta"),
                   (9, "Year's End"),
                   (10, "Burned"),
                   (11, "Vertigo"),]
        
        return eps.map { OldEpisode(number: $0.0, name: $0.1) }
    }
}