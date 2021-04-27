//
//  ReviewMovieService.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

// Service Configuration for Review Movie Request
class ReviewMovieService: BaseRequest {
    typealias ResponseType = ReviewMovieModel
    
    var url:String = ""
    
    func method() -> BaseNetwork.Method {
        return .get
    }
    
    func setUrl() -> URL {
        return URL(string: url)!
    }
}
