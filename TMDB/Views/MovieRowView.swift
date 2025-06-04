import Foundation
import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    @EnvironmentObject var favorites: FavoritesViewModel

    var body: some View {
        HStack(alignment: .top) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().aspectRatio(contentMode: .fit)
                    default:
                        Color.gray
                    }
                }
                .frame(width: 80, height: 120)
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(movie.title).font(.headline)
                    Spacer()
                    Button(action: {
                        if favorites.isFavorite(movie) {
                            favorites.remove(movie)
                        } else {
                            favorites.add(movie)
                        }
                    }) {
                        Image(systemName: favorites.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }

                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 4)
    }
}

