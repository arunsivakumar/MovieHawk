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
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        collectionView.collectionViewLayout = layout
        
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
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cells = 2
        print(self.view.frame.width)
        let width = (self.view.frame.width / CGFloat(cells)) - 40.0
        let height = width + 80.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }
}


extension SearchViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMovie"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                
                let movie = searchDataSource.movies[selectedIndexPath.row]
                
                let vc =
                    segue.destination as! MovieDetailViewController
                vc.movie = movie
            }

        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
}



