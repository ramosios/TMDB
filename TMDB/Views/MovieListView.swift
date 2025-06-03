import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieGPTViewModel()
    @State private var prompt = ""

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $prompt)
                    .frame(height: 100)
                    .border(Color.gray)
                    .padding()

                Button("Get Recommendations") {
                    Task {
                        await viewModel.getRecommendations(for: prompt)
                    }
                }
                .padding()

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    List(viewModel.movies) { movie in
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
            .navigationTitle("MovieGPT")
            .padding()
        }
    }
}
