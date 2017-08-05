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
        let url = URL(string: movie.posterURL)
        movieImageView.kf.setImage(with: url)
    }
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func watch(_ sender: UIButton) {
        movie.watchMovie()
    }
}

