//
//  MovieViewController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var movie:Movie!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var watchNowButton: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){

        movieImageView.kf.setImage(with: movie.posterURL)
    }

    
}

