//
//  FavoritesManager.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI
import CoreData

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()

    private let container: NSPersistentContainer = PersistenceController.shared.container
    private let context: NSManagedObjectContext

    @Published private(set) var favoriteIDs: Set<Int> = []

    private init() {
        self.context = container.viewContext
        loadFavorites()
    }


func loadFavorites() {
        let request = FavoriteMovie.fetchRequest()
        do {
            let favorites = try context.fetch(request)
            favoriteIDs = Set(favorites.map { Int($0.id) })
        } catch {
            print("Failed to fetch favorites: \(error)")
        }
    }

    func isFavorite(movie: Movie) -> Bool {
        favoriteIDs.contains(movie.id)
    }

    func toggle(movie: Movie) {
        if isFavorite(movie: movie) {
            remove(movie: movie)
        } else {
            add(movie: movie)
        }
        loadFavorites()
    }

    private func add(movie: Movie) {
        let favorite = FavoriteMovie(context: context)
        favorite.id = Int64(movie.id)
        do {
            try context.save()
        } catch {
            print("Failed to save favorite: \(error)")
        }
    }

    func remove(movie: Movie) {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        do {
            let result = try context.fetch(request)
            if let objectToDelete = result.first {
                context.delete(objectToDelete)
                try context.save()
            }
        } catch {
            print("Failed to remove favorite: \(error)")
        }
    }
}
