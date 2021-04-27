//
//  ListGenreModel.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

struct ListGenreModel : Codable {
    
    var genres : [Genre]?
    
    private enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres)
    }
}
