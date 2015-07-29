//
//  SeasonCellViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/27/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit
import FloatRatingView
import TraktModels
import Kingfisher

class SeasonViewCell: UITableViewCell {
    
    @IBOutlet weak var seasonPoster: UIImageView!
    
    @IBOutlet weak var seasonName: UILabel!
    
    @IBOutlet weak var numberOfEpisodes: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    private var task: RetrieveImageTask?
    
    func loadSeason(season: Season){
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        
        if let rating = season.rating {
            if let rate = formatter.stringFromNumber(season.rating!) {
                ratingLabel.text = rate
            }
            
            ratingView.rating = rating
        }
        
        if season.number == 0 {
            seasonName.text = "Specials"
        } else {
            seasonName.text = "Season \(season.number)"
        }
        
        numberOfEpisodes.text = "\(season.episodeCount!) episodes"
        
        let placeholder = UIImage(named: "poster")
        if let url = season.poster?.fullImageURL ?? season.poster?.mediumImageURL ?? season.poster?.thumbImageURL {
            task = seasonPoster.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            seasonPoster.image = placeholder
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        seasonPoster.image = nil
    }
    
    deinit {
        println("\(self.dynamicType) deinit")
    }
}