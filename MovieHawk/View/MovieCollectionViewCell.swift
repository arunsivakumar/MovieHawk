//
//  MovieCollectionViewCell.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell{
    
    //MARK:- Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    //MARK:- Variables
    
    var movie:Movie?{
        didSet{
            if let movie = movie{
                let url = URL(string: movie.posterURL)
                movieImageView.kf.setImage(with: url)
            }
        }
    }
    
     //MARK:- View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
