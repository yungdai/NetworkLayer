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

				MovieRow(movie: movie)
			}
			.navigationBarTitle(Text("Movies"))
		}
		.onAppear {
			self.movieStore.fetchMoviesOn(page: 1)
		}
		
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
			.environmentObject(MovieStore(networkManager: NetworkManager()))
    }
}
#endif
