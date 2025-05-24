//
//  MovieListView.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.filteredMovies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRow(movie: movie, isFavorite: viewModel.isFavorite(movie))
                }
                .onAppear {
                    viewModel.loadMoreIfNeeded(currentItem: movie)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search movies")
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                await viewModel.refresh()
            }
            .navigationTitle("Movies")
        }
    }
}
