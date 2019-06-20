//
//  MovieRow.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import SwiftUI

struct MovieRow : View {
	
	let movie: Movie
	
    var body: some View {
		
		HStack() {
			VStack(alignment: .leading) {
				Text(movie.title)
				Text(movie.releaseDate)
			}
			
			Spacer()
			Text(String(format:"Rating: %.1f", movie.rating))
		}
    }
}

#if DEBUG

let testMovie = Movie(id: 1, posterPath: "http:\\somePath.com", backdrop: "test Backdrop", title: "Some Title", releaseDate: "June 10, 2019", rating: 3.5, overview: "It was a great movie")

struct MovieRow_Previews : PreviewProvider {
    static var previews: some View {
		MovieRow(movie: testMovie)
    }
}
#endif
