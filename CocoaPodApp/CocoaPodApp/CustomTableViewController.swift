//
//  CustomTableViewController.swift
//  CocoaPodApp
//
//  Created by iOS on 7/21/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class CustomTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let entries = Entry.allEntries()
    
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        tableView.rowHeight
//    }
//    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Reusable.Cell.identifier!, forIndexPath: indexPath) as! CustomCellViewController
        
        if entries == nil {
            cell.loadNull()
            
            return cell
        }
        
        cell.loadEntry(entries![indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if entries == nil {
            return 1
        }
        
        return entries!.count
    }
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        var deselectedCell = tableView.cellForRowAtIndexPath(indexPath)!
//        deselectedCell.backgroundColor = UIColor.clearColor()
//        
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        UIApplication.sharedApplication().openURL(entries![indexPath.row].link)
    }
}
