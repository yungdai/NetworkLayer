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
