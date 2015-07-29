//
//  ShowCollectionCellViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowCollectionCellViewController: UICollectionViewCell {
    
    @IBOutlet weak var imageName: UIImageView!
    
    @IBOutlet weak var showName: UILabel!
    
    private var task: RetrieveImageTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadShow(show: Show) {
//        let formatter = NSNumberFormatter()
//        formatter.minimumIntegerDigits = 2
//        
//        if let number = formatter.stringFromNumber(index + 1) {
//            showName.text = "Show " + number
//        }
//        imageName.image = UIImage(named: "poster")
        
        showName.text = show.title
        
        let placeholder = UIImage(named: "poster")
        if let url = show.poster?.fullImageURL ?? show.poster?.mediumImageURL ?? show.poster?.thumbImageURL {
            task = imageName.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            imageName.image = placeholder
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        imageName.image = nil
    }

    deinit {
        println("\(self.dynamicType) deinit")
    }
}
