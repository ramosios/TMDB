//
//  ProfileView.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var watched: WatchedViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("🎬 MovieGPT")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text("Favorites: \(favorites.favorites.count)")
                Text("Watched: \(watched.watched.count)")

                Divider().padding(.vertical, 10)

                // View Watched Movies
                NavigationLink(destination: WatchedMoviesView()) {
                    Text("📺 View Watched Movies")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Clear Favorites
                Button(role: .destructive) {
                    favorites.clearAll()
                } label: {
                    Text("🗑️ Clear Favorites")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Clear Watched
                Button(role: .destructive) {
                    watched.clearAll()
                } label: {
                    Text("🧹 Clear Watched")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}
