//
//  BaseNetwork.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

// protocol for create service
protocol BaseRequest {
    associatedtype ResponseType: Codable
    
    func method() -> BaseNetwork.Method
    func setUrl() -> URL
}
