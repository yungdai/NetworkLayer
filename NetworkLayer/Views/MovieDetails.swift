//
//  MovieDetails.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-20.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import SwiftUI

struct MovieDetails : View {
	
	let movie: Movie
	
	@State var posterImage: Image = Image(systemName: "photo")
	@State var backdropImage: Image = Image(systemName: "photo")
	
	@State var posterVisible = false
	@State var backdropVisible = false
	
	var body: some View {
		
		GeometryReader { geometry in
			
			ZStack(alignment: .center) {
				
				if self.backdropVisible {
					self.backdropImage
						.resizable()
						.scaledToFill()
						.blur(radius: 15, opaque: true)
						.opacity(0.3)
						.frame(width: geometry.size.width, height: geometry.size.height)
						.animation(.basic(duration: 0.3, curve: .easeInOut))
				}

				VStack(alignment: .leading, spacing: 20) {
					Spacer()
					HStack {
						VStack(alignment: .leading) {
							Text(self.movie.title)
								.font(.title)
							Text(String(format: "Rating: %.1f", self.movie.rating))
							Text("Release Date: \(self.movie.releaseDate)")
						}
						
						Spacer()
						
						if self.posterVisible {
							self.posterImage
								.resizable()
								.frame(width: 60, height: 90)
								.scaledToFit()
								.opacity(1)
								.animation(.basic(duration: 0.3, curve: .easeInOut))
						}
					}
					.frame(height: 100)
					
					
					VStack(alignment: .leading) {
						Text("Overview:")
							.font(.headline)
						Text(self.movie.overview)
							.font(.body)
					}
					Spacer()
				}
				.padding(.horizontal, 10.0)
				.onAppear {
						
					self.movie.getImageForPosterPath
					{ image in
							
						self.posterImage = image
						self.posterVisible = true
					}
					
					self.movie.getImageForBackdropPath { image in
						
						self.backdropImage = image
						self.backdropVisible = true
					}
				}
			}
		}
		.edgesIgnoringSafeArea(.all)
	}
}

#if DEBUG
struct MovieDetails_Previews : PreviewProvider {
	static var previews: some View {
		MovieDetails(movie: testMovie, posterImage: Image("black-panther"), backdropImage: Image("black-panther"), posterVisible: true, backdropVisible: true)
	}
}
#endif
