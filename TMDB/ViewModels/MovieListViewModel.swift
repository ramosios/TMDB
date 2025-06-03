import Foundation

@MainActor
class MovieGPTViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    private let openAIService = OpenAIService()
    private let tmdbService = TMDBService()

    func getRecommendations(for prompt: String) async {
        isLoading = true
        do {
            let titles = try await openAIService.fetchMovieTitles(prompt: prompt)
            self.movies = try await tmdbService.fetchMovies(for: titles)
        } catch {
            print("Error: \(error)")
        }
        isLoading = false
    }
}
