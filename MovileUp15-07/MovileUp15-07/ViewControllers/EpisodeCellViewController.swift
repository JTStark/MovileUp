//
//  EpisodeCellViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit

class EpisodeCellViewController: UITableViewCell {
    
    @IBOutlet private weak var epNumb: UILabel!
    
    @IBOutlet private weak var epTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadEp(ep: Episode) {
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        
        if let number = formatter.stringFromNumber(ep.number) {
            epNumb.text = "S01E" + number
        }
        epTitle.text = ep.name
    }
}