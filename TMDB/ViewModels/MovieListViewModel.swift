import Foundation

@MainActor
class MovieGPTViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let openAIService = OpenAIService()
    private let tmdbService = TMDBService()
    
    func getRecommendations(for prompt: String, userPreferences:[String],avoiding moviesToAvoid: [Movie]) async {
        isLoading = true
        errorMessage = nil
        movies = []

        do {
            let titles = try await openAIService.fetchMovieTitles(prompt: prompt, userPreferences: userPreferences, excluding: moviesToAvoid)
            self.movies = try await tmdbService.fetchMovies(for: titles)
        } catch let error as LocalizedError {
            self.errorMessage = error.errorDescription
        } catch {
            self.errorMessage = "Unexpected error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
