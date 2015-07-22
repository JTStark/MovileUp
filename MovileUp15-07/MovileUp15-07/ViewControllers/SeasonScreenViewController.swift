//
//  EpisodesListViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit

class SeasonScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let eps = OldEpisode.allEpisodes()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Reusable.Cell.identifier!, forIndexPath: indexPath) as! EpisodeCellViewController
        
        cell.loadEp(eps[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
}
