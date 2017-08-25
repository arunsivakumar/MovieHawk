//
//  SearchStore.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation

typealias MovieCompletion = (MovieResult) -> Void

enum MovieResult{
    case success([Movie])
    case failure(Error)
}



class MovieStore{
    
    
    /**
     Fetches movies by Connecting to TMdb API.
     
     - Parameters:
     - completion: MovieCompletion.
     
     - Returns:
     Void
     */
    
    
    
    func fetchMovies(completion: @escaping MovieCompletion){
        
        let url = TmdbAPI.searchURL.absoluteString
        NetworkHelper.getRequest(url: url, params: nil) { (result) in
            let result = self.processRequest(for: result)
            completion(result)
        }
        
    }
    
    /**
     Process movies from NetworkResult.
     
     - Parameters:
     - for: NetworkResult
     - completion: MovieResult.
     
     - Returns:
     Void
     */
    
    
    private func processRequest(for result:NetworkResult) -> MovieResult{
        switch result{
        case .success(let json):
            return TmdbAPI.movies(from: json)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
