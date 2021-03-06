//
//  ParseHelper.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse

typealias PFQueryResult = (([PFObject]?,Error?) -> Void)

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
    static let movieClass       = "Movie"
    static let movieUser          = "user"
    static let movieId          = "id"
    static let movieCreatedAt     = "createdAt"
    
    static let username      = "username"
    
    
    
    /**
     Method to build Feed
     
     - Parameters:
     - skip: Int
     - limit: Int
     - completion: PFQueryResult
     - Returns:
     PFQueryResult
     */
    
    static func fetchFeed(skip: Int, limit: Int, completion: @escaping PFQueryResult)  {
        
        let followingQuery = PFQuery(className: followClass)
        followingQuery.whereKey(followFromUser, equalTo:PFUser.current()!)
        
        let postsFromFollowedUsers = Movie.query()
        postsFromFollowedUsers!.whereKey(movieUser, matchesKey: followToUser, in: followingQuery)
        
        let postsFromThisUser = Movie.query()
        postsFromThisUser!.whereKey(movieUser, equalTo: PFUser.current()!)

        let query = PFQuery.orQuery(withSubqueries: [postsFromFollowedUsers!, postsFromThisUser!])
        query.includeKey(movieUser)
        query.order(byDescending: movieCreatedAt)
        
        query.skip = skip
        query.limit = limit
        query.findObjectsInBackground { (result, error) in
            completion(result,error)
        }
        
        
    }
    
    /**
     Method to Fetch following userd
     
     - Parameters:
     - user: PFUSer
     - completion: PFQueryResult
     - Returns:
     PFQueryResult
     */
    
    static func fetchFollowingUsers(user: PFUser, completion: @escaping PFQueryResult){
        
        let query = PFQuery(className: followClass)
        
        print(user.username!)
       
        query.whereKey(followFromUser, equalTo:user)
        query.findObjectsInBackground { (result, error) in
            completion(result,error)
        }
    }
    
    /**
     Method to Fetch users
     
     - Parameters:
     - searchTerm: String
     - completion: PFQueryResult
     - Returns:
     PFQuery<PFObject>
     */
    
    static func fetchUsers(searchTerm: String, completion: @escaping PFQueryResult) -> PFQuery<PFObject> {
        var query = PFUser.query()!
        
        if searchTerm != ""{
            query = PFUser.query()!.whereKey(ParseHelper.username,
                                                 matchesRegex: searchTerm, modifiers: "i")
        }
        // exclude the current user
        query.whereKey(ParseHelper.username,
                       notEqualTo: PFUser.current()!.username!)
        query.order(byAscending: username)
        query.limit = 20
        
        query.findObjectsInBackground { (result, error) in
            completion(result,error)
        }
        return query
    }
    
    /**
     Method to follow user
     
     - Parameters:
     - user: PFUser
     - Returns:
     Void
     */
    
    
    
    static func followUser(user:PFUser){
        
        let followObject = PFObject(className: followClass)
        
        followObject.setObject(PFUser.current()!, forKey: followFromUser)
        followObject.setObject(user, forKey: followToUser)
        
        followObject.saveInBackground(block: nil)
    }
    
    
    /**
     Method to unfollow user
     
     - Parameters:
     - user: PFUser
     - Returns:
     Void
     */
    
    
    static func unfollowUser(user:PFUser){
        
        let query = PFQuery(className: followClass)
        
        query.whereKey(followFromUser, equalTo:PFUser.current()!)
         query.whereKey(followToUser, equalTo: user)
        
        query.findObjectsInBackground { (results, error) in
            let results = results ?? []
            for follow in results {
                follow.deleteInBackground(block: nil)
            }
        }
    }
    
    /**
     Method to fetch movies watched by user
     
     - Parameters:
     - completion: PFQueryResult
     - Returns:
     Void
     */
    
    static func fetchMoviesWatchedByUser(completion: @escaping PFQueryResult){
        let query = PFQuery(className: movieClass).whereKey(movieUser, equalTo: PFUser.current()!)
        query.includeKey(movieId)
        
        query.findObjectsInBackground { (result, error) in
            completion(result,error)
        }
        
        
    }
}


