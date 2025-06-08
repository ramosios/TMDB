import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var watched: WatchedViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    default:
                        Color.gray
                    }
                }
                .frame(width: 80, height: 120)
                .cornerRadius(12)
                .clipped()
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)

                HStack(spacing: 12) {
                    Button(action: {
                        if favorites.isFavorite(movie) {
                            favorites.remove(movie)
                        } else {
                            favorites.add(movie)
                            watched.remove(movie)
                        }
                    }) {
                        Image(systemName: favorites.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        if !watched.isWatched(movie) {
                            watched.markAsWatched(movie)
                            favorites.remove(movie)
                        }
                    }) {
                        Text(watched.isWatched(movie) ? "✅ Watched" : "Mark Watched")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}
