//
//  FeedTableViewcell.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import UIKit
import DateToolsSwift

class FeedTableViewCell: UITableViewCell {
    
     //MARK:- Outlets
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK:- Variables
    
    var movie:Movie?{
        didSet{
            if let movie = movie{
                let url = URL(string: movie.posterURL)
                movieImageView.kf.setImage(with: url)
                userLabel.text = movie.user?.username ?? ""
                timeLabel.text = movie.createdAt?.shortTimeAgo(since: Date()) ?? ""
            }
        }
    }
    
    //MARK:- View Lifecycle

    
    override func prepareForReuse() {
        movieImageView.image = nil
        userLabel.text = nil
        timeLabel.text = nil
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
