//
//  MovieSearchViewModel.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/27/25.
//

import SwiftUI
import Combine

@Observable class MovieSearchViewModel {
    var movieList = [MovieModel]()
    var userInput: String = ""
    var nextPage = 0
    var currentPage = 0
    var totalPages = 0
    
    func getMovies(page: Int) async {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "query", value: userInput),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let results = try? JSONDecoder().decode(MovieListModel.self, from: data) {
                currentPage = results.page
                if currentPage == 1 {
                    movieList = results.results
                    totalPages = results.totalPages
                } else {
                    movieList.append(contentsOf: results.results)
                }
            }
            nextPage = currentPage + 1
        } catch {
            print("Fetch error: ", error)
        }
    }
    
    func loadNextPage() async {
        guard nextPage < totalPages else {
            return
        }
        await getMovies(page: nextPage)
    }
    
    
    func createImageUrl(path: String?) -> URL? {
        guard let path = path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/original/"
        return URL(string: baseURL + path)
    }
    
    func formatDate(dateString: String, outputFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-mm-dd"
        guard let date = inputFormatter.date(from: dateString) else {
            return "Unknown"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: date)
    }
    
    func formatRating(rating: Float) -> String {
        rating == 0 ? "Unknown" : String(format: "%.1f", rating)
    }
    
    func getRatingScale(rating: Float) -> Float {
        return rating/10
    }
}
