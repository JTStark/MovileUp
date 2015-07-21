//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func readDataFromJSON() -> NSDictionary? {
    
    let path = NSBundle.mainBundle().pathForResource(NSLocalizedString("new-pods", comment: ""), ofType: "json")
    
    if (path != nil) {
        let data = NSData(contentsOfFile: path!)
        
        //self.jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        
        return NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(), error: nil) as? NSDictionary
    }
    
    return nil
}

//print(readDataFromJSON())






struct Entry {
    let content: String
    let contentSnippet: String
    let link: NSURL
    let publishedDate: NSDate
    let title: String
    
    static func decode(j: AnyObject?) -> Entry? {
        var i = 1
        //se o obj recebido for um dicionario, e seus campos forem todos strings
        println(j)
        if let json = j as? NSDictionary {
            println("\(i++)")
            
            if let cont = json["content"] as? String{
                println("\(i++)")
                
                if let contSnip = json["contentSnippet"] as? String{
                    println("\(i++)")
                    
                    if let ganon = json["link"] as? String{
                        println("\(i++)")
                        
                        if let strDate = json["publishedDate"] as? String{
                            println("\(i++)")
                            
                            if let titl = json["title"] as? String {
                                println("\(i++)")
                                
                                //converte-se a data e o URL para os tipos desejados
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
                                
                                //se o URL e data puderem ser alterados com sucesso, retorn-se a entry
                                if let url = NSURL.fileURLWithPath(ganon), date = dateFormatter.dateFromString(strDate) {
                                    return Entry(content: cont, contentSnippet: contSnip, link: url, publishedDate: date, title: titl)
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
}

func convertDicInVec(dic: NSDictionary?) -> [Entry]? {
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

let dict = readDataFromJSON()
let entries = convertDicInVec(dict)
