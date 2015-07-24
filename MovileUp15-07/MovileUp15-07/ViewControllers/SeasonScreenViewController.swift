//
//  EpisodesListViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit
import TraktModels

class SeasonScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //let eps = OldEpisode.allEpisodes()
    private let httpClient = TraktHTTPClient()
    var episodes: [Episode]?
    var show: Show!
    
    @IBOutlet weak var tableView: UITableView!
    
    func loadEpisodes(){
        httpClient.getEpisodes(show!.identifiers.slug!, season: 1) { [weak self] result in
            if let eps = result.value {
                self?.episodes = eps
                self?.tableView.reloadData()
            } else {
                println("oops \(result.error)")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let eps = episodes{
            return eps.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Reusable.Cell.identifier!, forIndexPath: indexPath) as! EpisodeCellViewController
        
        if let eps = episodes {
            cell.loadEp(eps[indexPath.row])
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        var deselectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        deselectedCell.backgroundColor = UIColor.clearColor()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            let vc = segue.destinationViewController as! EpisodeScreenViewController
            vc.episode = episodes![indexPath.row]
            vc.show = show
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodes()
    }
}
