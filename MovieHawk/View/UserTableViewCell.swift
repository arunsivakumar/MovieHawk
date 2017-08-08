//
//  UserTableViewCell.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit
import Parse

protocol friendSearchDelegate:class{
    func followUser(user:PFUser)
    func unfollowUser(user:PFUser)
}

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFollowButton: UIButton!
    
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
    
    @IBAction func followUser(_ sender: UIButton) {
        
        // optimestic UI update
        
        followingState == true ?  delegate?.unfollowUser(user: user) : delegate?.followUser(user: user)
        followingState = !followingState
    }
    func resetUI(){
        usernameLabel.text = nil
        userFollowButton.isSelected = false
    }

    
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
