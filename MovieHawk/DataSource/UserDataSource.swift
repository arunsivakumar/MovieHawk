//
//  UserDataSource.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation



import Foundation
import UIKit
import Parse

class UserDataSource:NSObject,UITableViewDataSource{
    
    var users = [PFUser]()
    var followingUsers:[PFUser]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)  as! UserTableViewCell
        
        let user = users[indexPath.row]
        cell.user = user
        
        if let followingUsers = followingUsers{

            
//FIXME:-
            var userFollowing = false
            
            for followingUser in followingUsers{
                if followingUser.objectId == user.objectId{
                    userFollowing = true
                    break
                }
            }
            
            cell.followingState = userFollowing
        }
        return cell
    }
}
