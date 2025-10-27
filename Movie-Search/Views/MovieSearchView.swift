//
//  ContentView.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/27/25.
//

import SwiftUI

struct MovieSearchView: View {
    @State private var viewModel = MovieSearchViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Movie Search")
                .font(.title)
                .padding()
            TextField("Search", text: $viewModel.userInput)
                .onSubmit {
                    Task {
                        await viewModel.getMovies()
                    }
                }
            List { // annie -- to switch to a ScrollView?
                ForEach(viewModel.movieList, id: \.id) { movie in
                    MovieListView(imageUrl: viewModel.createImageUrl(path: movie.posterPath), title: movie.title, releaseDate: movie.releaseDate)
                }
            }
        }
    }
}

#Preview {
    MovieSearchView()
}
