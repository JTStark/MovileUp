//
//  EpisodeScreenViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class EpisodeScreenViewController: UIViewController {
    
    @IBOutlet private weak var overviewLabelView: UILabel!
    
    @IBOutlet private weak var overviewImageView: UIImageView!
    
    @IBOutlet private weak var overviewTextView: UITextView!
    
    var episode: Episode!
    var show: Show!
    let httpClient = TraktHTTPClient()
    
    func loadEpisode(){
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        
        httpClient.getEpisode(show.identifiers.slug!, season: episode.seasonNumber, episodeNumber: episode.number){ [weak self] result in
            if let ep = result.value {
                self?.episode = ep
                
            } else {
                println("oops \(result.error)")
            }
        }
        
        let standBg = UIImage(named: "bg")
        if let url = episode.screenshot?.fullImageURL ?? episode.screenshot?.mediumImageURL ?? episode.screenshot?.thumbImageURL {
            overviewImageView.kf_setImageWithURL(url, placeholderImage: standBg)
        } else {
            overviewImageView.image = standBg
        }
        
        self.overviewLabelView.text = episode.title
        self.title = "Episode " + formatter.stringFromNumber(episode.number)!
        self.overviewTextView.text = episode.overview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEpisode()
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
    }
    
}
