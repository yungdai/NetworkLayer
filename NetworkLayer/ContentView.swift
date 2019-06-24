//
//  ContentView.swift
//  NetworkLayer
//
//  Created by Yung Dai on 2019-06-19.
//  Copyright © 2019 Yung Dai. All rights reserved.
//

import SwiftUI

struct ContentView : View {
	
	@EnvironmentObject var movieStore: MovieStore
	
    var body: some View {
		NavigationView {
			
			List(movieStore.movies) { movie in
				
				NavigationButton(destination: MovieDetails(movie: movie)) {
					MovieRow(movie: movie)
				}
			}
			
			.navigationBarTitle(Text("Movies Now Playing"))

		}
		.onAppear {
			self.movieStore.fetchMoviesOn(page: 1)
		}
	}
	
}

struct NewList: View {
	
	var body: some View {
		
		HStack {
			Text("Left Text")
			Spacer()
			Image(systemName: "picture")
		}
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		Group {
			ContentView()
				.environmentObject(MovieStore(networkManager: NetworkManager()))
			
			NewList()
		}
    }
}
#endif
