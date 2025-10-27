//
//  MovieListModel.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/27/25.
//

struct MovieListModel: Codable {
    var page: Int
    var results: [MovieModel]
}

