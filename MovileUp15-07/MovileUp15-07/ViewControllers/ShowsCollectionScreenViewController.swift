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
    private var popShows: [Show]?
    private var favShows: [Show]?
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    private let name = FavoritesManager.favoritesChangedNotificationName
    private var page = 1 //number of pages loaded in the popular tab
    
    @IBOutlet weak var segView: UISegmentedControl!
    
    @IBOutlet weak var collView: UICollectionView!
    
    func loadPopShows(){
        
        //se jah houver  popular shows armazenados, apenas atualizamos a Collection View
        if let series = popShows {
            
            collView.reloadData()
            
        } else {
            //se nao houver, faz-se o request
            
            httpClient.getPopularShows { [weak self] result in
                if let series = result.value {
                    self?.popShows = series
                    self?.collView.reloadData()
                }
            }
            
        }
        
    }
    
    func loadFavShows() {
        
        if let series = favShows {
            collView.reloadData()
            
        } else {
            var favs = favMan.favoritesIdentifiers
            
            if let series = popShows {
                
                favShows = popShows?.filter({ favs.contains($0.identifiers.trakt) })
                loadRestOfFavs(page+1)
                
            } else {
                
                httpClient.getPopularShows { [weak self] result in
                    if let series = result.value?.filter({ favs.contains($0.identifiers.trakt) }) {
                        self?.favShows = series
                        self?.collView.reloadData()
                    }
                }
                
                loadRestOfFavs(page+1)
                
            }
        }
    }
    
//    func loadFavShows() {
//        var favs = favMan.favoritesIdentifiers
////        var aux: [Show] = shows ?? []
//        
//        httpClient.getPopularShows { [weak self] result in
//            if let series = result.value?.filter({ favs.contains($0.identifiers.trakt) }) {
//                self?.favShows = series
//                self?.collView.reloadData()
//            }
//        }
////            for var i = 1; shows?.count < favs.count; i++ {
////                aux = shows ?? []
////                httpClient.getMorePopShows(i, completion: { [weak self] result in
////                    if let series = result.value?.filter({ favs.contains($0.identifiers.trakt) }) {
////                        self?.shows = aux + series
////                        self?.collView.reloadData()
////                    }
////                })
////            }
//        
//    }
    
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
        
        if segView.selectedSegmentIndex == 0 {
            if let series = popShows {
                cell.loadShow(series[indexPath.item])
            }
            
        } else if segView.selectedSegmentIndex == 1 {
            if let series = favShows {
                cell.loadShow(series[indexPath.item])
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segView.selectedSegmentIndex == 0 {
            if let series = popShows {
                return series.count
            }
            
        } else if segView.selectedSegmentIndex == 1 {
            if let series = favShows {
                return series.count
            }
        }
        
        return 0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UICollectionViewCell, indexPath = collView.indexPathForCell(sender as! UICollectionViewCell) {
            let vc = segue.destinationViewController as! ShowViewController
            
            if segView.selectedSegmentIndex == 0 {
                if let series = popShows {
                    vc.show = series[indexPath.row]
                }
                
            } else if segView.selectedSegmentIndex == 1 {
                if let series = favShows {
                    vc.show = series[indexPath.row]
                }
            }
        }
        
    }
    
    //funcao chamada se o scroll chega ao fim da tela
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        //se for na aba dos popular shows
        if segView.selectedSegmentIndex == 0 {
            
            //carrega-se mais popular shows
            httpClient.getMorePopShows(++page, completion: { [weak self] result in
                if let series = result.value {
                    
                    if let aux = self?.popShows {
                        
                        self?.popShows = aux + series
                        
                    } else {
                        
                        self?.popShows = series
                        
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
        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    func favoritesChanged() {
        let favs = favMan.favoritesIdentifiers
        favShows = popShows?.filter({ favs.contains($0.identifiers.trakt) })
        changeShows(self)
    }
    
    func loadRestOfFavs(i: Int) {
        var favs = favMan.favoritesIdentifiers
        
        if favShows?.count < favs.count {
//            
//            println(i)
//            
            httpClient.getMorePopShows(i, completion: { [weak self] result in
                if let series = result.value?.filter({ favs.contains($0.identifiers.trakt) }) {
                    
                    if let aux = self?.favShows {
                        
                        self?.favShows = aux + series
                        
                    } else {
                        
                        self?.favShows = series
                        
                    }
//                    self?.collView.reloadData()
//                    
                }
                
                self?.loadRestOfFavs(i+1)
            })
            
        } else {
            collView.reloadData()
        }
    }
    
    @IBAction func changeShows(sender: AnyObject) {
        if segView.selectedSegmentIndex == 0 {
            loadPopShows()
        } else if segView.selectedSegmentIndex == 1 {
            loadFavShows()
        }
    }
    
}