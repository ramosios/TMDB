import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieGPTViewModel()
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var watched: WatchedViewModel
    @State private var prompt = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    PromptInputView(prompt: $prompt) {
                        Task {
                            let avoid = favorites.favorites + watched.watched
                            await viewModel.getRecommendations(for: prompt, avoiding: avoid)
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
                .padding()
                .background(Color(.systemGroupedBackground))
            }
            .navigationTitle("🍿 MovieGPT")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
