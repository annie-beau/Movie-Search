//
//  MovieModel.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/27/25.
//

import Foundation

struct MovieModel: Codable, Equatable, Hashable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let rating: Float
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
}
