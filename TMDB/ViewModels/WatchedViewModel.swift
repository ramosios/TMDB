//
//  WatchedViewModel.swift
//  TMDB
//
//  Created by Jorge Ramos on 05/06/25.
//
import Foundation

class WatchedViewModel: ObservableObject {
    @Published private(set) var watched: [Movie] = []

    private let filename = "watched_movies.json"

    init() {
        loadWatched()
    }

    func markAsWatched(_ movie: Movie) {
        guard !watched.contains(where: { $0.id == movie.id }) else { return }
        watched.append(movie)
        saveWatched()
    }

    func isWatched(_ movie: Movie) -> Bool {
        watched.contains(where: { $0.id == movie.id })
    }
    
    func clearAll() {
            watched.removeAll()
            saveWatched()
    }

    private func fileURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }

    private func saveWatched() {
        do {
            let data = try JSONEncoder().encode(watched)
            try data.write(to: fileURL())
        } catch {
            print("❌ Failed to save watched movies: \(error)")
        }
    }

    private func loadWatched() {
        do {
            let data = try Data(contentsOf: fileURL())
            watched = try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            watched = []
        }
    }
}
