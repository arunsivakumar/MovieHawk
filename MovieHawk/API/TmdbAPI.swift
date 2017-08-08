//
//  TmdbAPI.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import SwiftyJSON

enum TmdbError: Error{
    case invalidJSON
}


enum TmdbMethod:String{
    case discoverMovie = "discover/movie"
}

class TmdbAPI{
    
    static var secureBaseImageURLString =  "https://image.tmdb.org/t/p/"
    static var posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
    
    
    //https://api.themoviedb.org/3?language=en-US&api_key=0707e815068096f71fb530c047ea18b1&method=/discover/movie&include_video=false&include_adult=false&sort_by=popularity.desc&page=1
    
    private static let baseURLString =  "https://api.themoviedb.org/3/"
    
    private static let apiKey = "0707e815068096f71fb530c047ea18b1"
    
    private static func constructURL(method:TmdbMethod, parameters:[String:String]?) -> URL{
        
        var components = URLComponents(string:baseURLString + method.rawValue)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParameters = [
//            "method": method.rawValue,
            "api_key": apiKey,
            "language": "en-US",
            "include_adult": "false",
            "include_video" : "false"
            
        ]
        
        for (key, value) in baseParameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let parameters = parameters{
            for(key,value) in parameters{
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        return components.url!
    }

    
    static var searchURL:URL{
        return constructURL(method: .discoverMovie, parameters: ["sort_by":"popularity.desc","page":"1"])
    }
    
    
    static func movies(from json: JSON) -> MovieResult{
//        print(json)
        
        var movieItems = [Movie]()
        
        guard
            let movieArray = json["results"].array else{
                
                return .failure(TmdbError.invalidJSON)
        }
        
        for movieJSON in movieArray{
            if let movie = movie(from: movieJSON){
                movieItems.append(movie)
            }else{
                // invalid json
            }
        }
        return .success(movieItems)
    }
    
    private static func movie(from json:JSON) -> Movie?{
//        print(json)
        guard
            let id = json["id"].int,
            let title = json["title"].string,
            let overview = json["overview"].string,
            let urlString = json["poster_path"].string,
            let posterURL = URL(string: secureBaseImageURLString + posterSizes[3] + urlString)
        else{
//            print(json["id"].int)
//            print(json["title"].string)
//            print(json["poster_path"].string)
                // Information is not enough to construct a photo
                return nil
        }
        
        print(posterURL.absoluteString)
        return Movie(id: id, title: title, posterURL: posterURL, overview: overview)
    }

}
