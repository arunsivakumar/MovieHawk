//
//  Movie.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation

class Movie{
    
    var id: Int
    var title: String
    var posterURL: URL
    
    init(id: Int, title: String, posterURL: URL){
        
        self.id = id
        self.title = title
        self.posterURL = posterURL
    }
    
}

