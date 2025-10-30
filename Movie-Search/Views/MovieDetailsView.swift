//
//  MovieDetailsView.swift
//  Movie-Search
//
//  Created by Annie Beaulieu on 10/29/25.
//

import SwiftUI

struct MovieDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var title: String
    var date: String
    var imageUrl: URL?
    var rating: String
    var overview: String
    var progress: Float
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Movie Search")
                }
                .foregroundColor(.blue)
            }
            Divider()
            HStack(alignment: .top) {
                AsyncImage(url: imageUrl) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(2/3, contentMode: .fit)
                    } else {
                        Image(systemName: "photo")
                    }
                }.frame(width: 75)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primary)
                    Text(date)
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                        .padding(.bottom, 1)
                    Text("Viewer Rating")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                    Text("\(rating)/10")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                    ProgressView(value: progress)
                }.padding(.all, 5)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            Divider()
            Text("Overview".uppercased())
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.secondary)
            //                .padding(.top, 1)
                .padding(.vertical, 1)
            Text(overview)
                .font(.subheadline)
                .padding(.bottom, 1)
            Divider()
            Spacer()
        }.padding(.all, 25)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MovieDetailsView(title: "Fight Club", date: "July 12, 2025", imageUrl: nil, rating: "8.4", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", progress: 0.8)
}
