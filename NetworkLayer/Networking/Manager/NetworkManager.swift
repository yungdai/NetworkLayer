//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-19.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import Foundation
import SwiftUI


struct NetworkManager {
	
	static let environment: NetworkEnvironment = .production
	static let MovieAPIKey = "YOUR_API_KEY"
	private let router = Router<MovieApi>()
	
	enum NetworkResponseError: String, Error {

		case authenticationError = "You need to be authenticated first."
		case badRequest = "Bad request"
		case outdated = "The url you requested is outdated."
		case failed = "Network request failed."
		case noData = "Response returned with no data to decode."
		case unableToDecode = "We would not decode the response."
	}

	fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponseError {
		
		switch response.statusCode {
		case 401...500: return .authenticationError
		case 501...599: return .badRequest
		case 600: return .outdated
		default: return .failed
		}
	}
	
	func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: NetworkResponseError?) -> ()) {
		
		router.request(.newMovies(page: page)) { (result, response) in
			
			if let response = response as? HTTPURLResponse {

				switch result {
					
				case .success(let data):
					
					guard let responseData = data else {
						completion(nil, NetworkResponseError.noData)
						return
					}
					
					do {
						let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
						
						completion(apiResponse.movies, nil)
					} catch {
						completion(nil, NetworkResponseError.unableToDecode)
					}
					
				case .failure(_):
					
					let networkResponseError = self.handleNetworkResponse(response)
					
					completion(nil, networkResponseError)
				}
				
			}
		}
	}
}


