//
//  JSONConverter.swift
//  CocoaPodApp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import Foundation

class JSONConverter {
    
    //var jsonData: NSDictionary = [:]
    
    func readDataFromJSON() -> NSDictionary? {
        
        let path = NSBundle.mainBundle().pathForResource(NSLocalizedString("new-pods", comment: ""), ofType: "json")
        
        if (path != nil) {
            let data = NSData(contentsOfFile: path!)
            
            //self.jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        
            return NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary
        }
        
        return nil
    }
    
    
    
}