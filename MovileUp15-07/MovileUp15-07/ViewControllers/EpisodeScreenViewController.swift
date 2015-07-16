//
//  EpisodeScreenViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit

class EpisodeScreenViewController: UIViewController {
    
    @IBOutlet private weak var overviewLabelView: UILabel!
    
    @IBOutlet private weak var overviewImageView: UIImageView!
    
    @IBOutlet private weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
    }
    
}
