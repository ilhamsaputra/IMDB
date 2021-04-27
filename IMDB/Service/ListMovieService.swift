//
//  ListMovieService.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

// Service Configuration for List Movie Request
class ListMovieService: BaseRequest {
    typealias ResponseType = ListMovieModel
    
    var url:String = ""
    
    func method() -> BaseNetwork.Method {
        return .get
    }
    
    func setUrl() -> URL {
        return URL(string: url)!
    }
}
