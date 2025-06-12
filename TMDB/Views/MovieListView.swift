import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieGPTViewModel()
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var watched: WatchedViewModel
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    @State private var prompt = ""

    var body: some View {
        NavigationView {
            VStack {
                PromptInputView(prompt: $prompt) {
                    Task {
                        let avoid = favorites.favorites + watched.watched
                        let userPreferences = userPreferences.selectedAnswers
                        await viewModel.getRecommendations(for: prompt, userPreferences: userPreferences, avoiding: avoid)
                    }
                }

                if let error = viewModel.errorMessage {
                    ErrorBanner(message: error)
                }

                if viewModel.isLoading {
                    LoadingView()
                } else {
                    MovieListSection(movies: viewModel.movies)
                }
            }
            .navigationTitle("MovieGPT")
        }
    }
}
