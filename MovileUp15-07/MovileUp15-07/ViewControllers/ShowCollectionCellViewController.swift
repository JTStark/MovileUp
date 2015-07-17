//
//  ShowCollectionCellViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit

class ShowCollectionCellViewController: UICollectionViewCell {
    
    @IBOutlet weak var imageName: UIImageView!
    
    @IBOutlet weak var showName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadShow(index: Int) {
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        
        if let number = formatter.stringFromNumber(index + 1) {
            showName.text = "Show " + number
        }
        
        imageName.image = UIImage(named: "poster")
    }
}
