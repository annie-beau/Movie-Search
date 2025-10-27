//
//  MovieSearchViewModel.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/27/25.
//

import SwiftUI
import Combine

@Observable class MovieSearchViewModel {
    // annie -- add an init?
    var movieList = [MovieModel]()
    var userInput: String = ""
    
    // annie - add pagination
    func getMovies() async {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "query", value: userInput), // annie - can't hard code this
            URLQueryItem(name: "page", value: "1"), // annie - can't hard code this
            URLQueryItem(name: "include_adult", value: "false")
        ]
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        do {
            // get data
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // decode json to model format
            if let results = try? JSONDecoder().decode(MovieListModel.self, from: data) {
                movieList = results.results
            }
        } catch {
            print("Fetch error: ", error)
        }
    }
    
    func createImageUrl(path: String?) -> URL? {
        guard let path = path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/original/"
        return URL(string: baseURL + path)
    }
}
