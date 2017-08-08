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
    
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    
    var searchTerm = ""{
        didSet{
            fetchUsers(searchTerm: searchTerm)
        }
    }
    
    private var userDataSource:UserDataSource! = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDataSource = UserDataSource(store: store)
        
        tableView.dataSource = userDataSource
        tableView.delegate = self
        
        fetchUsers()
        fetchFollowing()
    }
    
    func fetchUsers(searchTerm: String = ""){
        store.fetchUsers (searchTerm: searchTerm){ [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
    
    func fetchFollowing(){
        store.fetchFollowing { [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
}

// MARK: Searchbar Delegate

extension UserViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
}

extension UserViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}


