//
//  FavoritesView.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var manager = FavoritesManager.shared
    @State private var allMovies: [Movie] = []

    var body: some View {
        NavigationStack {
            List(allMovies.filter { manager.isFavorite(movie: $0) }) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRow(movie: movie, isFavorite: true)
                }
            }
            .navigationTitle("Favorites")
        }
        .task {
            do {
                allMovies = try await TMDBService().fetchPopularMovies(page: 1)
            } catch {
                print("Failed to load movies: \(error)")
            }
        }
    }
}
