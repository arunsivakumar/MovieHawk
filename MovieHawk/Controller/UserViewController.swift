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
    
    
    fileprivate enum SearchState{
        case none
        case search
    }
    
    var store:UserStore!
    
    fileprivate var searchState: SearchState = .none{
        
        didSet{
            switch searchState {
            case .none:
                fetchUsers(searchTerm: "")
            case .search:
                fetchUsers(searchTerm: "")
            }
        }
    }
    
    fileprivate let userDataSource = UserDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = userDataSource
        tableView.delegate = self
        
        searchState = .none
        fetchFollowing()
    }
    
    func fetchUsers(searchTerm: String){
        store.fetchUsers (searchTerm: searchTerm){ (result) in
            switch result{
            case let .success(users):
                self.userDataSource.users = users
            case .failure(_):
                break
            }
            self.tableView.reloadData()
        }
    }
    
    func fetchFollowing(){
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
