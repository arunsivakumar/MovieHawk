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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
         titleLabel.text = movie.title
        descriptionTextField.text = movie.overview
        movieImageView.kf.setImage(with: movie.posterURL)
    }
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
}

