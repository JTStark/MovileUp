//
//  CustomCellViewController.swift
//  CocoaPodApp
//
//  Created by iOS on 7/21/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit

class CustomCellViewController: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contSnip: UILabel!
    
    func loadEntry(entry: Entry) {
        var delimiter = "\n"
        var paragraphs = entry.contentSnippet.componentsSeparatedByString(delimiter)
        
        titleLabel.text = entry.title
        
        contSnip.text = paragraphs[0]
        contSnip.numberOfLines = 0
    }
    
    func loadNull() {
        titleLabel.text = "Null Pod"
        contSnip.text = "Null Pod List"
    }
}
