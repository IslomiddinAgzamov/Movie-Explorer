//
//  MovieListViewModel.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""


    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private let service = TMDBService()
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePages = true
    private let favoritesManager = FavoritesManager.shared

    init() {
        Task {
            await fetchMovies(reset: true)
        }
    }

    func refresh() async {
        currentPage = 1
        hasMorePages = true
        await fetchMovies(reset: true)
    }

    func loadMoreIfNeeded(currentItem item: Movie?) {
        guard let item = item else { return }
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            Task {
                await fetchMovies(reset: false)
            }
        }
    }

    func fetchMovies(reset: Bool) async {
        guard !isLoading && hasMorePages else { return }
        isLoading = true

        do {
            let fetched = try await service.fetchPopularMovies(page: currentPage)

            if reset {
                movies = fetched
            } else {
                movies += fetched
            }

            currentPage += 1
            hasMorePages = !fetched.isEmpty
        } catch {
            print("Error fetching movies: \(error)")
        }

        isLoading = false
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favoritesManager.isFavorite(movie: movie)
    }
}
