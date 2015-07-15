//
//  AppDelegate.swift
//  MovileUp15-07
//
//  Created by iOS on 7/15/15
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = .orangeColor()
        
        let attributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        appearance.titleTextAttributes = attributes
        appearance.tintColor = .whiteColor()
        
        return true
    }
}
