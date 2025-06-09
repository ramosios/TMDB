//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Jorge Ramos on 09/06/25.
//
import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Poster image
                if let url = movie.posterURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
                            Color.gray
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .cornerRadius(12)
                }

                // Title + badge
                HStack(spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .lineLimit(2)
                    
                    if let popularity = movie.popularity {
                        if popularity >= 1000 {
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                Text("Blockbuster")
                            }
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red.opacity(0.15))
                            .foregroundColor(.red)
                            .cornerRadius(8)
                        } else if popularity >= 100 {
                            HStack(spacing: 2) {
                                Image(systemName: "flame.fill")
                                Text("Trending")
                            }
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.orange.opacity(0.15))
                            .foregroundColor(.orange)
                            .cornerRadius(8)
                        }
                    }
                }
                // Release date, popularity, rating
                HStack {
                    Text("Release: \(movie.formattedReleaseDate)")
                    Spacer()
                    Text("⭐️ \(movie.formattedVoteAverage)")
                }
                .font(.subheadline)

                // Overview
                Text(movie.overview)
                    .font(.body)
                    .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
