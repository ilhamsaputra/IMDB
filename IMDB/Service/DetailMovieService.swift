//
//  DetailMovieService.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

// Service Configuration for Detail Movie Request
class DetailMovieService: BaseRequest {
    typealias ResponseType = DetailMovieModel
    
    var url:String = ""
    
    func method() -> BaseNetwork.Method {
        return .get
    }

    func setUrl() -> URL {
        return URL(string: url)!
    }
}
