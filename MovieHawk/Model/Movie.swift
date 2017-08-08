//
//  Movie.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse

class Movie: PFObject, PFSubclassing {
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var posterURL: String
    @NSManaged var overview: String
    
    @NSManaged var user: PFUser?
    
    
    init(id: Int, title: String, posterURL: URL,overview: String){
        super.init()
    
        self.id = id
        self.title = title
        self.posterURL = posterURL.absoluteString
        self.overview = overview
        
    }
    
    override init () {
        super.init()
    }
    
    // PF subclassing
    static func parseClassName() -> String {
        return "Movie"
    }
    
    func watchMovie(){
//        print(self.user?.username)
        user = PFUser.current()
        saveInBackground()
    }
    
    func findIfUserWatchedMovie(completion: @escaping (Bool) -> Void){
        ParseHelper.fetchMoviesWatchedByUser() { (result, error) in
            let movies = result as? [Movie] ?? []
            
            let movieWatched = movies.filter ({ $0.id == self.id })
            
            if (movieWatched.count) > 0 {
                completion(true)
            }else{
               completion(false)
            }
        }
        
    }
    
}

