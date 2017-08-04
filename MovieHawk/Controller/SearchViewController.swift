//
//  SearchViewController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var store:MovieStore!
    let searchDataSource = SearchDataSource()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = searchDataSource
        
        loadData()
    }
    
    
    func loadData(){
        store.fetchMovies { (movieResult) in
            switch movieResult{
            case let .success(movies):
                self.searchDataSource.movies = movies
            case .failure(_):
                self.searchDataSource.movies.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer:0))
        }
        
    }
    
    
}


extension SearchViewController:UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cells = 2
        let width = (self.view.frame.width / CGFloat(cells))
        let height = width
        return CGSize(width: width, height: height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
    }
}


extension SearchViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMovie"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
}



