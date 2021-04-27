//
//  Movie.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

struct Movie: Codable {

	let title: String
	let id: Int
	let posterPath: String
	let overview: String
	let releaseDate: String

	private enum CodingKeys: String, CodingKey {
		case title = "title"
		case id = "id"
		case posterPath = "poster_path"
		case overview = "overview"
		case releaseDate = "release_date"
	}
    
    init(id:Int, overview:String, posterPath:String, releaseDate:String, title:String) {
           self.id = id
           self.overview = overview
           self.posterPath = posterPath
           self.releaseDate = releaseDate
           self.title = title
       }

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decode(String.self, forKey: .title)
		id = try values.decode(Int.self, forKey: .id)
		posterPath = try values.decode(String.self, forKey: .posterPath)
		overview = try values.decode(String.self, forKey: .overview)
		releaseDate = try values.decode(String.self, forKey: .releaseDate)
	}
}
