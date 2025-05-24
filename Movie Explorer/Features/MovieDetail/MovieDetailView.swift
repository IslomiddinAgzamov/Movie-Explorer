//
//  MovieDetailView.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject private var favoritesManager = FavoritesManager.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle().fill(Color.gray)
                }
                
                Text(movie.title).font(.title)
                Text("Release Date: \(movie.releaseDate)")
                Text("Rating: \(movie.rating, specifier: "%.1f")")
                Text(movie.overview)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    favoritesManager.toggle(movie: movie)
                }) {
                    Image(systemName: favoritesManager.isFavorite(movie: movie) ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
}
