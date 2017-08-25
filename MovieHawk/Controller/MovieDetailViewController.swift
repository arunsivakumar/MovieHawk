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
    
    //MARK:- Public API
    
    var movie:Movie!
    
    //MARK:- Outlets

    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var watchNowButton: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData()
    }
    
    //MARK:- Functions

    
    func configureUI(){
        watchNowButton.setTitle("--", for: .normal)
        disableWatchButton()
    }
    
    func disableWatchButton(){
        watchNowButton.setTitle("Watched", for: .normal)

        watchNowButton.isEnabled = false
        watchNowButton.backgroundColor = Constants.watchButtonDisabledColor
    }
    
    func enableWatchButton(){
        watchNowButton.setTitle("Watch Now", for: .normal)

        watchNowButton.isEnabled = true
        watchNowButton.backgroundColor = Constants.watchButtonEnabledColor
    }
    
    func loadData(){
         titleLabel.text = movie.title
        descriptionTextField.text = movie.overview
        let url = URL(string: movie.posterURL)
        movieImageView.kf.setImage(with: url)
        
        movie.findIfUserWatchedMovie { (result) in
            result == false ? self.enableWatchButton() : self.disableWatchButton()
        }
        
    }
    
    //MARK:- Actions

    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func watch(_ sender: UIButton) {
        disableWatchButton()
        movie.watchMovie()
    }
}

