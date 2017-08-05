//
//  FeedStore.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse

class FeedStore{
    
    func fetchFeed(completion: @escaping MovieCompletion){
        
        ParseHelper.fetchFeed { (result, error) in
            let processResult = self.processRequest(for: result, error: error)
            completion(processResult)
        }
    }

    private func processRequest(for result:[PFObject]?, error: Error?) -> MovieResult{
        guard let movies = result as? [Movie] else{
            return .failure(error!)
        }
        return .success(movies)
    }
}
