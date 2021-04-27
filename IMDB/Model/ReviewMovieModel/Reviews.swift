//
//  Reviews.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

struct Reviews: Codable {

	let author: String
	let content: String
	let id: String
	let url: String

	private enum CodingKeys: String, CodingKey {
		case author = "author"
		case content = "content"
		case id = "id"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		author = try values.decode(String.self, forKey: .author)
		content = try values.decode(String.self, forKey: .content)
		id = try values.decode(String.self, forKey: .id)
		url = try values.decode(String.self, forKey: .url)
	}

}
