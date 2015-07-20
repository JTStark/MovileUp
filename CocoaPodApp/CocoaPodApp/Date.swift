//
//  Date.swift
//  CocoaPodApp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import Foundation

struct Date {
    let weekDay: String
    let day: Int
    let month: String
    let year: String
    let hours: Int
    let minutes: Int
    let seconds: Int
    let hourZone: Int
    
    func printDate() {
        print(weekDay + ", \(day) " + month + " " + year + " \(hours):\(minutes):\(seconds) \(hourZone)")
    }
}