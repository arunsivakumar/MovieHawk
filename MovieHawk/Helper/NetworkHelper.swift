//
//  NetworkHelper.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation


import Foundation
import Alamofire
import SwiftyJSON


typealias NetworkResponse = (NetworkResult) -> Void

enum NetworkResult{
    case success(JSON)
    case failure(Error)
}
struct NetworkHelper{
    
    static func getData(url:String,params: [String:String]?, completion: @escaping NetworkResponse){
        
        Alamofire.request(url).validate(statusCode: 200..<300).responseJSON { (response) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completion(.success(json))
                }else{
                    
                }
                
            case .failure(let error):
                //print(error)
                completion(.failure(error))
            }
        }
    }
}
