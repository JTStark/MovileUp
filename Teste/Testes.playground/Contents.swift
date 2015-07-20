//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func readDataFromJSON() -> NSDictionary? {
    
    let path = NSBundle.mainBundle().pathForResource(NSLocalizedString("new-pods", comment: ""), ofType: "json")
    
    if (path != nil) {
        let data = NSData(contentsOfFile: path!)
        
        //self.jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        
        return NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary
    }
    
    return nil
}

print(readDataFromJSON())
