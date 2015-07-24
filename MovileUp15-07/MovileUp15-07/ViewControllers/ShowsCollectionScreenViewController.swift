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
    private var shows: [Show]?
    
    @IBOutlet weak var collView: UICollectionView!
    
    func loadPopShows(){
        httpClient.getPopularShows { [weak self] result in
            if let series = result.value {
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
            let vc = segue.destinationViewController as! SeasonScreenViewController
            vc.show = shows![indexPath.row]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopShows()
    }
    
}