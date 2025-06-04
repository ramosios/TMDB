//
//  FavoritesViewModel.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import Foundation

class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [Movie] = []

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
}
