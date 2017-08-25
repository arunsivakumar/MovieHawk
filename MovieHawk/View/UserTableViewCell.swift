//
//  UserTableViewCell.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit
import Parse

//MARK:-Delegate

protocol friendSearchDelegate:class{
    func followUser(user:PFUser)
    func unfollowUser(user:PFUser)
}

class UserTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFollowButton: UIButton!
    
    //MARK:- Variables
    
    weak var delegate:friendSearchDelegate?
    
    var user:PFUser!{
        didSet{
            usernameLabel.text = user.username
        }
    }
    
    var followingState:Bool = false{
        didSet{
            userFollowButton.isSelected = followingState
        }
    }
    
      //MARK:- Actions
    
    @IBAction func followUser(_ sender: UIButton) {
        
        // optimestic UI update
        
        followingState == true ?  delegate?.unfollowUser(user: user) : delegate?.followUser(user: user)
        followingState = !followingState
    }
    
      //MARK:- functions
    func resetUI(){
        usernameLabel.text = nil
        userFollowButton.isSelected = false
    }

      //MARK:- View Lifecycle
    
    override func prepareForReuse() {
        resetUI()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resetUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
