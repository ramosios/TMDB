import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let movieService: MovieService

    init(movieService: MovieService) {
        self.movieService = movieService
    }

    func fetchMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            movies = try await movieService.fetchPopularMovies()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
