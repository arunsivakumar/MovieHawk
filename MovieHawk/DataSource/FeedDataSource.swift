//
//  FeedDataSource.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import UIKit

class FeedDataSource:NSObject,UITableViewDataSource{
    
    //MARK:- Public API
    
    var movies = [Movie]()
    
      //MARK:- DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath)  as! FeedTableViewCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}
