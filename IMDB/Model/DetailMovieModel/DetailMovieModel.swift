//
//  DetailMovieModel.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

struct DetailMovieModel: Codable {
    
    let id: Int
    let overview: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        overview = try values.decode(String.self, forKey: .overview)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        backdropPath = try values.decode(String.self, forKey: .backdropPath)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        title = try values.decode(String.self, forKey: .title)
    }
    
}
