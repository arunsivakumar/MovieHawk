//
//  UserTableViewCell.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit
import Parse



class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userFollowButton: UIButton!
    
    
    var user:PFUser?{
        didSet{
            if let user = user{
                usernameLabel.text = user.username
            }
        }
    }
    
    var followingState:Bool? = false{
        didSet{
            if let followingState = followingState{
                userFollowButton.isSelected = followingState
            }
        }
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
