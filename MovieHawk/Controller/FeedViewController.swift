//
//  ViewController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController,FeedComponentTarget {

    var feedCompletion: FeedCompletion! = {_ in}

    var skip = 0
    var limit = 2
    
    var store:FeedStore<FeedViewController>!
    
    fileprivate var feedDataSource:FeedDataSource! = nil
    
    @IBOutlet weak var tableView: UITableView!

    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        configureTableView()
        configureCompletion()
        loadData()
    }
    
    func configureTableView(){
        
         feedDataSource = FeedDataSource()
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.dataSource = feedDataSource
        tableView.delegate = self
    }
    
    func configureCompletion(){
        
        feedCompletion = { [weak self] results in
            
            self?.refreshControl.endRefreshing()
            
            switch results {
            case .success:
                self?.feedDataSource.movies = (self?.store.movies)!
            case .failure(_): break
                
            }
            self?.tableView.reloadData()
        }
    }
    
    func loadData(){
        self.refreshControl.beginRefreshing()
        store.loadInitial()
    }
}

extension FeedViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width + 60.0 + 2.0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        store.targetWillDisplayCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovie", sender: self)
    }
    
    
}


extension FeedViewController{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMovie"?:
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                
                let movie = store.movies[selectedIndexPath.row]
                
                let vc =
                    segue.destination as! MovieDetailViewController
                vc.movie = movie
            }
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
