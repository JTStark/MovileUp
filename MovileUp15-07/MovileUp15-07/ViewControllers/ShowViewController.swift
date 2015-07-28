//
//  ShowViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/27/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher


class ShowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let httpClient = TraktHTTPClient()
    private let favMan = FavoritesManager()
    var seasons: [Season]?
    var show: Show!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var showBG: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    func loadSeasons(){
        httpClient.getSeasons(show.identifiers.slug!) { [weak self] result in
            if let seas = result.value {
                self?.seasons = seas.filter({ $0.airedEpisodes > 0 })
                self?.seasons?.sort({ $0.number > $1.number })
                self?.tableView.reloadData()
                self?.title = self?.show.title
                
                let standBg = UIImage(named: "bg")
                if let url = self?.show.thumbImageURL ?? self?.show.logoImageURL ?? self?.show.clearArtImageURL {
                    self?.showBG.kf_setImageWithURL(url, placeholderImage: standBg)
                } else {
                    self?.showBG.image = standBg
                }
                
            } else {
                println("oops \(result.error)")
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Reusable.SeasonCell.identifier!, forIndexPath: indexPath) as! SeasonViewCell
        
        if let seas = seasons {
            cell.loadSeason(seas[indexPath.row])
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sea = seasons {
            return sea.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        var deselectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        deselectedCell.backgroundColor = UIColor.clearColor()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSeasons()
        
        let favs = favMan.favoritesIdentifiers
        let id = show.identifiers.trakt
        
        if favs.contains(id) {
            likeButton.selected = true
        } else {
            likeButton.selected = false
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.showBottomHairline()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            let vc = segue.destinationViewController as! SeasonScreenViewController
            vc.season = seasons![indexPath.row]
            vc.show = show
        }
        
    }
    
    @IBAction func like(sender: AnyObject) {
        let favs = favMan.favoritesIdentifiers
        let id = show.identifiers.trakt
        
        if favs.contains(id) {
            
            favMan.removeIdentifier(id)
            likeButton.selected = false
            
        } else {
            
            favMan.addIdentifier(id)
            likeButton.selected = true
            
        }
    }
    
}