//
//  ListGenreService.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

// Service Configuration for List Genre Request
class ListGenreService: BaseRequest {
    typealias ResponseType = ListGenreModel
    
    var url:String = ""
    
    func method() -> BaseNetwork.Method {
        return .get
    }
    
    func setUrl() -> URL {
        return URL(string: url)!
    }
}
