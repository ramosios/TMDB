import SwiftUI

struct MovieRowView: View {
    let movie: Movie

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

            VStack(alignment: .leading) {
                Text(movie.title).font(.headline)
                Text(movie.overview).font(.subheadline).lineLimit(3)
            }
        }
        .padding(.vertical, 4)
    }
}
