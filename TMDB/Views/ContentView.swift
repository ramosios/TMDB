//
//  ContentView.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import Foundation
import SwiftUI
struct ContentView: View {
    @StateObject var favorites = FavoritesViewModel()

    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }

            FavoritesView()
                .tabItem {
                    Label("Watchlist", systemImage: "heart.fill")
                }
        }
        .environmentObject(favorites)
    }
}
