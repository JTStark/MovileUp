//
//  JSONConverter.swift
//  CocoaPodApp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import Foundation

class JSONConverter {
    
    static func readDataFromJSON() -> NSDictionary? {
        
        let path = NSBundle.mainBundle().pathForResource(NSLocalizedString("new-pods", comment: ""), ofType: "json")
        
        if (path != nil) {
            let data = NSData(contentsOfFile: path!)
            
            return NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary
        }
        
        return nil
    }
    
    
    static func convertDicInVec(dic: NSDictionary?) -> [Entry]? {
        if dic == nil {
            return nil
        }
        
        var vec: [Entry] = []
        
        //se o dicionario recebido tiver o formato esperado, verifica-se o vetor "entries" para retorná-lo devidamente formatado
        if let respData = dic?["responseData"] as? NSDictionary, feed = respData["feed"] as? NSDictionary, entries = feed["entries"] as? [NSDictionary]{
            
            for x in entries {
                
                if let entry = Entry.decode(x) {
                    vec.append(entry)
                }
            }
        }
        
        return vec
    }
}