//
//  ShowsCollectionScreenViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit
import TraktModels

class ShowsCollectionScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let httpClient = TraktHTTPClient()
    private let favMan = FavoritesManager()
    private var shows: [Show]?
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    private let name = FavoritesManager.favoritesChangedNotificationName
    private var page = 1
    
    @IBOutlet weak var segView: UISegmentedControl!
    
    @IBOutlet weak var collView: UICollectionView!
    
    func loadPopShows(){
        httpClient.getPopularShows { [weak self] result in
            if let series = result.value {
                self?.shows = series
                self?.collView.reloadData()
            }
        }
    }
    
    func loadFavShows() {
        var favs = favMan.favoritesIdentifiers
        
        httpClient.getPopularShows { [weak self] result in
            if let series = result.value?.filter({ favs.contains($0.identifiers.trakt) }) {
                self?.shows = series
                self?.collView.reloadData()
            }
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space, bottom: flowLayout.sectionInset.bottom, right: space)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(Reusable.CollectionCell, forIndexPath: indexPath) as! ShowCollectionCellViewController
        
        if let series = shows {
            cell.loadShow(series[indexPath.item])
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let series = shows {
            return series.count
        }
        return 0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UICollectionViewCell, indexPath = collView.indexPathForCell(sender as! UICollectionViewCell) {
            let vc = segue.destinationViewController as! ShowViewController
            vc.show = shows![indexPath.row]
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if segView.selectedSegmentIndex == 0 {
            httpClient.getMorePopShows(++page, completion: { [weak self] result in
                if let series = result.value {
                    if let aux = self?.shows {
                        self?.shows = aux + series
                    } else {
                        self?.shows = series
                    }
                    self?.collView.reloadData()
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopShows()
        
        notificationCenter.addObserver(self, selector: "favoritesChanged", name: name, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self, name: name, object: nil)
        println("\(self.dynamicType) deinit")
    }
    
    override func viewWillAppear(animated: Bool) {
        page = 1
        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    func favoritesChanged() {
        changeShows(self)
    }
    
    
    @IBAction func changeShows(sender: AnyObject) {
        if segView.selectedSegmentIndex == 0 {
            loadPopShows()
        } else {
            loadFavShows()
        }
    }
    
}