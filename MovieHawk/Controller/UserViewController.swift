//
//  UserViewController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import UIKit


class UserViewController: UIViewController {
    
    var store:UserStore!
    
    fileprivate let userDataSource = UserDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = userDataSource
        tableView.delegate = self
        
        loadData()
    }
    
    func loadData(){

        store.fetchAllUsers { (result) in
            switch result{
            case let .success(users):
                self.userDataSource.users = users
            case .failure(_):
                break
            }
            self.tableView.reloadData()
        }
        
        store.fetchFollowing { (result) in
            switch result{
            case let .success(users):
                self.userDataSource.followingUsers = users
                self.tableView.reloadData()
            default: break
            }
        }
    }
}

extension UserViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
