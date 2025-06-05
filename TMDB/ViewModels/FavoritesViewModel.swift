//
//  FavoritesViewModel.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import Foundation

class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [Movie] = [] {
        didSet {
            saveFavorites()
        }
    }

    private let storageKey = "FAVORITES"

    init() {
        loadFavorites()
    }

    func add(_ movie: Movie) {
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
        }
    }

    func remove(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }

    func clearAll() {
        favorites.removeAll()
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([Movie].self, from: data) {
            self.favorites = saved
        }
    }
}
