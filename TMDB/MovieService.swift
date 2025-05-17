import Foundation

protocol MovieService {
    func fetchPopularMovies() async throws -> [Movie]
}

final class DefaultMovieService: MovieService {
    private let apiKey = "22ba04af8c691f90a7f04e80c131dbab"
    private let baseURL = "https://api.themoviedb.org/3"

    func fetchPopularMovies() async throws -> [Movie] {
        guard let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
    }
}
