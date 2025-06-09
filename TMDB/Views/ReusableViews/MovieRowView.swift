import SwiftUI
import Foundation

struct MovieRowView: View {
    let movie: Movie
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var watched: WatchedViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let img):
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    default:
                        Color.gray
                    }
                }
                .frame(width: 80, height: 120)
                .cornerRadius(8)
                .clipped()
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)

                // POPULARITY & VOTE AVERAGE
                HStack {
                    if let popularity = movie.popularity {
                            if popularity >= 80 {
                                // Blockbuster badge
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
                            } else if popularity >= 35 {
                                // Trending badge
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
                    Text("⭐️ \(movie.voteAverage?.formatted() ?? "-")")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }

                // Optionally, add release date here
                if let date = movie.releaseDate {
                    Text("Release: \(date)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 12) {
                    // Favorite toggle
                    Button(action: {
                        if favorites.isFavorite(movie) {
                            favorites.remove(movie)
                        } else {
                            favorites.add(movie)
                            watched.remove(movie) // ✅ remove from watched
                        }
                    }) {
                        Image(systemName: favorites.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())

                    // Watched toggle
                    Button(action: {
                        if !watched.isWatched(movie) {
                            watched.markAsWatched(movie)
                            favorites.remove(movie) // ✅ remove from favorites
                        }
                    }) {
                        Text(watched.isWatched(movie) ? "✅ Watched" : "Mark Watched")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(watched.isWatched(movie) ? Color.green.opacity(0.8) : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .padding(.vertical, 6)
    }
}
