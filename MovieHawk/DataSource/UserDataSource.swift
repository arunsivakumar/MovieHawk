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
    
     //MARK:- Public API
    weak var store:UserStore!
    
//    var users = [PFUser]()
//    var followingUsers:[PFUser]?
    
//    weak var vc:UIViewController?
//    
    init(store:UserStore) {
        self.store = store
        super.init()
    }

     //MARK:- DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)  as! UserTableViewCell
        
        let user = store.users[indexPath.row]
        cell.delegate = self
        cell.user = user
        
        if let followingUsers = store.followingUsers{
            cell.followingState = followingUsers.filter{ $0.objectId == user.objectId}.count > 0
        }
        return cell
    }
}
//MARK:- Cell Delegates

extension UserDataSource:friendSearchDelegate{
    func followUser(user: PFUser) {
        store.follow(user: user)
    }
    
    func unfollowUser(user: PFUser) {
        store.unFollow(user: user)
    }
}
