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
    
//    static func decode(j: AnyObject?) -> Entry?
    
    func convertDicInVec(dic: NSDictionary?) -> [Entry]? {
        if dic == nil {
            return nil
        }
        
        var vec: [Entry] = []
        var aux: Entry
        
        if let respData = dic["responseData"] as? NSDictionary, feed = respData["feed"] as? NSDictionary, entries = feed["entries"] as? [NSDictionary]{
            
            for x in dic["responseData"]["feed"]["entries"] {
                aux.content = x["content"]
                aux.contentSnippet = x["contentSnippet"]
                aux.link = x["link"]
                aux.publishedDate = x["publishedDate"]
                aux.title = x["title"]
                
                vec.append(aux)
            }
        }
        
        return vec
    }
}