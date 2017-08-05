//
//  ViewController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var store:FeedStore!
    
    fileprivate let feedDataSource = FeedDataSource()
    
    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = feedDataSource
        tableView.delegate = self
        
        loadData()
    }
    
    func loadData(){
        
        store.fetchFeed { (feedResult) in
            switch feedResult{
            case let .success(movies):
                self.feedDataSource.movies = movies
            case .failure(_):
                self.feedDataSource.movies.removeAll()
            }
            self.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width + 60.0 + 2.0
    }
}


extension FeedViewController{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMovie"?:
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                
                let movie = feedDataSource.movies[selectedIndexPath.row]
                
                let vc =
                    segue.destination as! MovieDetailViewController
                vc.movie = movie
            }
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
