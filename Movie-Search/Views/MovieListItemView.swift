//
//  MovieListItemView.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/27/25.
//

import SwiftUI

struct MovieListItemView: View {
    var imageUrl: URL?
    var title: String
    var releaseDate: String
    
    var body: some View {
        HStack {
            AsyncImage(url: imageUrl) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(2/3, contentMode: .fit)
                } else {
                    Image(systemName: "photo")
                }
            }.frame(width: 75)
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(releaseDate).font(.footnote)
                    .foregroundStyle(Color.secondary) // annie: circle back
            }
        }
    }
}

#Preview {
    MovieListItemView(title: "Example Title", releaseDate: "2021")
}
