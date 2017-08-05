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
    case success([PFUser])
    case failure(Error)
}


class UserStore{
    
    func fetchAllUsers(completion: @escaping UserCompletion){
        
        ParseHelper.fetchAllUsers { (result, error) in
            let processResult = self.processRequest(for: result, error: error)
            completion(processResult)
        }
    }
    
    private func processRequest(for result:[PFObject]?, error: Error?) -> UserResult{
        guard let users = result as? [PFUser] else{
            return .failure(error!)
        }
        return .success(users)
    }
    
    private func processRequestForFollowing(for result:[PFObject]?, error: Error?) -> UserResult{
        guard let users = result else{
            return .failure(error!)
        }
        var followingUsers = [PFUser]()
        followingUsers = users.map {
            $0.object(forKey: ParseHelper.followToUser) as! PFUser
        }
        return .success(followingUsers)
    }
    
    func fetchFollowing(completion: @escaping UserCompletion){
        
        ParseHelper.fetchFollowingUsers (user: PFUser.current()!){ (result, error) in
            let processResult = self.processRequestForFollowing(for: result, error: error)
            completion(processResult)
        }
        
    }
}
