//
//  ReviewMovieModel.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

struct ReviewMovieModel: Codable {

	let id: Int
	let page: Int
	let reviews: [Reviews]
	let totalPages: Int
	let totalResults: Int

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case page = "page"
		case reviews = "results"
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		page = try values.decode(Int.self, forKey: .page)
		reviews = try values.decode([Reviews].self, forKey: .reviews)
		totalPages = try values.decode(Int.self, forKey: .totalPages)
		totalResults = try values.decode(Int.self, forKey: .totalResults)
	}

}
