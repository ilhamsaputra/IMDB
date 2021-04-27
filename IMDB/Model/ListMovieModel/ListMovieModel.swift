//
//  ListMovieModel.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

struct ListMovieModel: Codable {

	let totalPages: Int
	let totalResults: Int
	let movies: [Movie]
	let page: Int
    
	private enum CodingKeys: String, CodingKey {
		case totalPages = "total_pages"
		case totalResults = "total_results"
		case movies = "results"
		case page = "page"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		totalPages = try values.decode(Int.self, forKey: .totalPages)
		totalResults = try values.decode(Int.self, forKey: .totalResults)
		movies = try values.decode([Movie].self, forKey: .movies)
		page = try values.decode(Int.self, forKey: .page)
	}

}



