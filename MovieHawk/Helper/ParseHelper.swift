//
//  ParseHelper.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse


enum ParseError{
    case success([PFObject])
    case failure(Error)
}

class ParseHelper {

    
    // Following Relation
    static let followClass       = "Follow"
    static let followFromUser    = "fromUser"
    static let followToUser      = "toUser"
    
    // Watch Relation
    static let watchClass         = "Like"
    static let watchToMovie       = "toMovie"
    static let watchFromUser      = "fromUser"
    
    // Post Relation
    static let movieUser          = "user"
    static let movieCreatedAt     = "createdAt"
    
    
    static func fetchFeed(completion: @escaping ([PFObject]?,Error?) -> Void) {
        
        let followingQuery = PFQuery(className: followClass)
        followingQuery.whereKey(followFromUser, equalTo:PFUser.current()!)
        
        let postsFromFollowedUsers = Movie.query()
        postsFromFollowedUsers!.whereKey(movieUser, matchesKey: followToUser, in: followingQuery)
        
        let postsFromThisUser = Movie.query()
        postsFromThisUser!.whereKey(movieUser, equalTo: PFUser.current()!)

        let query = PFQuery.orQuery(withSubqueries: [postsFromFollowedUsers!, postsFromThisUser!])
        query.includeKey(movieUser)
        query.order(byDescending: movieCreatedAt)
        
        query.skip = 0
        query.limit = 5
        query.findObjectsInBackground { (result, error) in
            completion(result,error)
        }
        
        
    }
    
}

