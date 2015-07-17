//
//  ShowsCollectionScreenViewController.swift
//  MovileUp15-07
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 JTStark. All rights reserved.
//

import UIKit

class ShowsCollectionScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
//  let shows = Show.loadShows
    
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
        
        cell.loadShow(indexPath.item)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 50
        
//      return shows.count
    }
    
}