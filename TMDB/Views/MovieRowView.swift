import SwiftUI

struct MovieListSection: View {
    let movies: [Movie]

    var body: some View {
        List(movies) { movie in
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
}
