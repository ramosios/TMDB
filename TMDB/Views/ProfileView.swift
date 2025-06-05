//
//  ProfileView.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var favorites: FavoritesViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(role: .destructive) {
                    favorites.clearAll()
                } label: {
                    Text("🗑️ Clear Watchlist")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.8))
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
