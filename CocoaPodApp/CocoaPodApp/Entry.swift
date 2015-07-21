//
//  Entry.swift
//  CocoaPodApp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import Foundation

struct Entry {
    let content: String
    let contentSnippet: String
    let link: NSURL
    let publishedDate: NSDate 
    let title: String
    
    static func decode(j: AnyObject?) -> Entry? {
        //se o obj recebido for um dicionario, e seus campos forem todos strings
        if let json = j as? NSDictionary,
            cont = json["content"] as? String, contSnip = json["contentSnippet"] as? String, ganon = json["link"] as? String, strDate = json["publishedDate"] as? String, titl = json["title"] as? String {
                
                //converte-se a data e o URL para os tipos desejados
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
                
                //se o URL e data puderem ser alterados com sucesso, retorn-se a entry
                if let url = NSURL(string: ganon), date = dateFormatter.dateFromString(strDate) {
                    return Entry(content: cont, contentSnippet: contSnip, link: url, publishedDate: date, title: titl)
                }
        }
        
        return nil
    }
    
    static func allEntries() -> [Entry]? {
        var dic = JSONConverter.readDataFromJSON()
        
        return JSONConverter.convertDicInVec(dic)
    }
}
