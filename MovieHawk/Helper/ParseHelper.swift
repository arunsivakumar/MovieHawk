//
//  ParseHelper.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Parse


class ParseHelper {

    
    // Following Relation
    static let ParseFollowClass       = "Follow"
    static let ParseFollowFromUser    = "fromUser"
    static let ParseFollowToUser      = "toUser"
    
    // Like Relation
    static let ParseWatchClass         = "Like"
    static let ParseWatchToMovie       = "toMovie"
    static let ParseWatchFromUser      = "fromUser"
    
    // Post Relation
    static let ParseMovieUser          = "user"
    static let ParseMovieCreatedAt      = "createdAt"
    
}

