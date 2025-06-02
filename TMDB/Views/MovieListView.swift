import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel(movieService: DefaultMovieService())

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                } else {
                    List(viewModel.movies) { movie in
                        MovieRowView(movie: movie)
                    }
                }
            }
            .navigationTitle("Popular Movies")
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}
