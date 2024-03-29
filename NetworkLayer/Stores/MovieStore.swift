//
//  MovieStore.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import SwiftUI
import Combine

class MovieStore: BindableObject {
	
	var movies: [Movie] = [] {
		didSet {
			didChange.send(self)
		}
	}
	
	var didChange = PassthroughSubject<MovieStore, Never>()
	
	let networkManager: NetworkManager
	
	init(networkManager: NetworkManager) {
		
		self.networkManager = networkManager
	}
	
	func fetchMoviesOn(page: Int) {
		
		networkManager.getNewMovies(page: page) { [unowned self] (movies, error) in

			DispatchQueue.main.async {
				
				if let movies = movies {
					
					self.movies = movies
				}
				
				if let error = error {
					
					print("Error: \(error)")
				}
			}
		}
	}
}

//
//extension UIImage {
//	
//	func loadImageFrom(urlString: String) {
//		
//		guard let url = URL(string: urlString) else { print("The string is not a URL String")
//			return
//		}
//		
//		DispatchQueue.global().async {
//			
//			if let data = try? Data(contentsOf: url),
//				let image = UIImage(data: data) {
//				DispatchQueue.main.async {
//					self = image
//				}
//			}
//		}
//	}
//}
