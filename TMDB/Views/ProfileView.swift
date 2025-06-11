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
    @State private var showingConfirmReset = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile header
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)

                        Text("MovieGPT User")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("You’ve watched \(watched.watched.count) movies")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)

                    // Action list
                    VStack(spacing: 16) {
                        NavigationLink(destination: WatchedMoviesView()) {
                            HStack {
                                Image(systemName: "eye.fill")
                                Text("View Watched Movies")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                        }
                        NavigationLink(destination: UserPreferenceView()) {
                            HStack {
                                Image(systemName: "eye.fill")
                                Text("Movie Preferences")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                        }

                        Button(role: .destructive) {
                            showingConfirmReset = true
                        } label: {
                            HStack {
                                Image(systemName: "trash")
                                Text("Clear All Data")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(12)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .alert("Are you sure you want to clear all data?", isPresented: $showingConfirmReset) {
                Button("Clear All", role: .destructive) {
                    watched.clearAll()
                    favorites.clearAll()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}
