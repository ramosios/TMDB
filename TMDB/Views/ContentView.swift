//
//  ContentView.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import Foundation
import SwiftUI
struct ContentView: View {
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

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
