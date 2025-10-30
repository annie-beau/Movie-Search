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
        NavigationStack {
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                        .padding()
                    TextField("Search", text: $viewModel.userInput)
                        .onChange(of: viewModel.userInput) {
                            Task {
                                await viewModel.getMovies(page: 1)
                            }
                        }
                    Button {
                        viewModel.userInput = ""
                        viewModel.movieList = []
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.gray)
                    }.padding()
                }
                .frame(height: 25)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .background(Color(red: 0.9, green: 0.9, blue: 0.9).clipShape(RoundedRectangle(cornerRadius:10)))
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                
                Divider()
                if viewModel.movieList == [] {
                    VStack {
                        Spacer()
                        Text("No results")
                        Spacer()
                    }.frame(maxWidth: .infinity)
                } else {
                    List {
                        ForEach(viewModel.movieList, id: \.id) { movie in
                            ZStack(alignment: .leading) {
                                MovieListItemView(imageUrl: viewModel.createImageUrl(path: movie.posterPath), title: movie.title, releaseDate: viewModel.formatDate(dateString: movie.releaseDate, outputFormat: "yyyy"))
                                    .onAppear {
                                        if movie == viewModel.movieList.last {
                                            Task {
                                                await viewModel.loadNextPage()
                                            }
                                        }
                                    }
                                NavigationLink(value: movie) {
                                    EmptyView()
                                }.opacity(0)
                            }
                        }
                    }.listStyle(PlainListStyle())
                        .navigationDestination(for: MovieModel.self) { movie in
                            MovieDetailsView(title: movie.title,
                                             date: viewModel.formatDate(dateString: movie.releaseDate, outputFormat: "MMMM d, yyyy"),
                                             imageUrl: viewModel.createImageUrl(path: movie.posterPath),
                                             rating: viewModel.formatRating(rating: movie.rating),
                                             overview: movie.overview,
                                             progress: viewModel.getRatingScale(rating: movie.rating))
                        }
                }
            }.navigationTitle("Movie Search")
        }
    }
}

#Preview {
    MovieSearchView()
}
