//
//  FavoritesView.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import SwiftUI
import Foundation

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesViewModel

    var body: some View {
        NavigationView {
            if favorites.favorites.isEmpty {
                Text("You haven't added any favorites yet.")
                    .padding()
                    .navigationTitle("Watchlist")
            } else {
                MovieListSection(movies:favorites.favorites)
                .navigationTitle("Watchlist")
            }
        }
    }
}
