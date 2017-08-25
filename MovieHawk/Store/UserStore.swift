//
//  UserStore.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse

typealias UserCompletion = (UserResult) -> Void

enum UserResult{
    case success
    case failure(Error)
}


class UserStore{
    
    var users = [PFUser]()
    var followingUsers:[PFUser]?
    
    // holds the last query and cancels if the query parameter changes
    
    var userQuery: PFQuery<PFObject>?{
        didSet{
            oldValue?.cancel()
        }
    }
    
    
    
    /**
     Fetch users
     
     - Parameters:
     - searchTerm: String
     - completion: UserCompletion.
     
     - Returns:
     Void
     */
    
    
    
    func fetchUsers(searchTerm: String, completion: @escaping UserCompletion){
        
        userQuery = ParseHelper.fetchUsers (searchTerm: searchTerm){ (result, error) in
            let processResult = self.processRequest(for: result, error: error)
            completion(processResult)
        }
    }
    
    
    /**
     Process user Request
     
     - Parameters:
     - result: String
     - completion: UserResult.
     
     - Returns:
     Void
     */
    
    
    
    private func processRequest(for result:[PFObject]?, error: Error?) -> UserResult{
        guard let users = result as? [PFUser] else{
            return .failure(error!)
        }
        self.users = users
        return .success
    }
    
    /**
     Process following Request
     
     - Parameters:
     - result: Optional Array of PFObjects
     - completion: UserResult.
     
     - Returns:
     Void
     */
    
    
    private func processRequestForFollowing(for result:[PFObject]?, error: Error?) -> UserResult{
        guard let users = result else{
            return .failure(error!)
        }
        var followingUsers = [PFUser]()
        followingUsers = users.map {
            $0.object(forKey: ParseHelper.followToUser) as! PFUser
        }
        self.followingUsers = followingUsers
        return .success
    }
    
    
    /**
     Fetches user following
     
     - Parameters:
     - completion: UserCompletion.
     
     - Returns:
     Void
     */
    
    
    func fetchFollowing(completion: @escaping UserCompletion){
        
        ParseHelper.fetchFollowingUsers (user: PFUser.current()!){ (result, error) in
            let processResult = self.processRequestForFollowing(for: result, error: error)
            completion(processResult)
        }
        
    }
    
    //MARK:- follow/Unfollow
    
    func follow(user:PFUser){
        followingUsers?.append(user)
        ParseHelper.followUser(user: user)
    }
    
    func unFollow(user:PFUser){
        self.followingUsers = followingUsers?.filter { $0 != user}
        ParseHelper.unfollowUser(user: user)
    }
    
    
}
