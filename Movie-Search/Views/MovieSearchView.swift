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
        List {
            ForEach(viewModel.movieList, id: \.id) { movie in
                // annie: make this a seperate view
                HStack {
                    AsyncImage(url: viewModel.createImageUrl(path: movie.posterPath)) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .aspectRatio(2/3, contentMode: .fit)
                        } else {
                            Image(systemName: "photo")
                        }
                    }.frame(width: 75)
                    VStack(alignment: .leading) {
                        Text("\(movie.title)").font(.headline)
                        Text("\(movie.releaseDate)").font(.footnote)
                            .foregroundStyle(Color.gray) // annie: circle back
                    }
                }
            }
        }.task {
            await viewModel.getMovies()
        }
    }
    
    }

#Preview {
    MovieSearchView()
}
