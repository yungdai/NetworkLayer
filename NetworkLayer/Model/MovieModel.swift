//
//  MoveModel.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-19.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieApiResponse {

	let page: Int
	let numberOfResults: Int
	let numberOfPages: Int
	let movies: [Movie]
}

extension MovieApiResponse: Decodable {
	
	private enum MovieApiResponseCodingKeys: String, CodingKey {
		
		case page
		case numberOfResults = "total_results"
		case numberOfPages = "total_pages"
		case movies = "results"
	}
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
		
		page = try container.decode(Int.self, forKey: .page)
		numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
		numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
		movies = try container.decode([Movie].self, forKey: .movies)
	}
}

struct Movie: Identifiable {
	
	let id: Int
	let posterPath: String
	let backdrop: String
	let title: String
	let releaseDate: String
	let rating: Double
	let overview: String
}

extension Movie: Decodable {
	
	enum MovieCodingKeys: String, CodingKey {
		
		case id
		case postPath = "poster_path"
		case backdrop = "backdrop_path"
		case title
		case releaseDate = "release_date"
		case rating = "vote_average"
		case overview
	}
	
	init(from decoder: Decoder) throws {
		
		let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
		
		id = try movieContainer.decode(Int.self, forKey: .id)
		posterPath = try movieContainer.decode(String.self, forKey: .postPath)
		backdrop = try movieContainer.decode(String.self, forKey: .backdrop)
		title = try movieContainer.decode(String.self, forKey: .title)
		releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
		rating = try movieContainer.decode(Double.self, forKey: .rating)
		overview = try movieContainer.decode(String.self, forKey: .overview)
	}
	
	func getImageForPosterPath(completion: @escaping(Image) -> ()) {

		let fullURLString = "https://image.tmdb.org/t/p/original/\(self.posterPath)"
		
		if let url = URL(string: fullURLString) {
			
			Image.getImageFrom(url: url) { image in
				completion(image)
			}
		}
	}
	
	func getImageForBackdropPath(completion: @escaping(Image) ->()) {
		
		let fullURLString = "https://image.tmdb.org/t/p/original/\(self.backdrop)"
		
		if let url = URL(string: fullURLString) {
			
			Image.getImageFrom(url: url) { image in

				completion(image)
			}
		}
	}
}

extension Image {
	
	static func getImageFrom(url: URL, completion: @escaping(Image) -> ()) {

		DispatchQueue.global().async {
			
			if let data = try? Data(contentsOf: url),
				let uiImage = UIImage(data: data) {
				
				completion(Image(uiImage: uiImage))
			}
		}
	}
}


