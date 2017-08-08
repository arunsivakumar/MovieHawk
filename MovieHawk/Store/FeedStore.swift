//
//  FeedStore.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse

typealias FeedCompletion = (FeedResult) -> Void

enum FeedResult{
    case success
    case failure(Error)
}

protocol FeedComponentTarget:class{
    
    var skip: Int {get}
    var limit: Int {get}
    var feedCompletion:FeedCompletion! { get set}
}

class FeedStore<S:FeedComponentTarget>{
    
    var movies = [Movie]()
    
    var skip = 0
    var limit = 0
    
    var loadedAllData = false
    
    weak var target:S?
    
    public init(target:S){
        self.target = target
        self.skip = target.skip
        self.limit = target.limit
    }
    
    func loadInitial(){
        skip = 0
        movies.removeAll()
        loadedAllData = false
        
        fetchFeed(skip: self.skip, limit: self.limit)
    }
    
    
    func loadMore(){
        if !loadedAllData{
            fetchFeed(skip: self.skip, limit: self.limit)
        }
    }
    func fetchFeed(skip: Int, limit: Int){
        
        ParseHelper.fetchFeed(skip: skip, limit: limit) { (result, error) in
            let result = self.processRequest(for: result, error: error)
            DispatchQueue.main.async {
                self.target?.feedCompletion(result)
            }
        }
    }

    private func processRequest(for result:[PFObject]?, error: Error?) -> FeedResult{
        guard let movies = result as? [Movie] else{
            return .failure(error!)
        }
        if (movies == []) {
            loadedAllData = true
        }else {
            self.skip += limit
            self.movies += movies
        }
        
        return .success
    }
    
    func targetWillDisplayCell(index: Int){
        if index == movies.count - 1{
            loadMore()
        }
    }
}
