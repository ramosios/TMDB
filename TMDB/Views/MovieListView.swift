import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieGPTViewModel()
    @State private var prompt = ""
    @EnvironmentObject var favorites: FavoritesViewModel
    @EnvironmentObject var watched: WatchedViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Describe the type of movies you want:")
                        .font(.headline)
                        .padding(.horizontal)

                    TextEditor(text: $prompt)
                        .frame(height: 120)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                        .padding(.horizontal)
                }

                Button(action: {
                    Task {
                        let avoiding = favorites.favorites + watched.watched
                                await viewModel.getRecommendations(for: prompt, avoiding: avoiding)
                    }
                }) {
                    Text("🎬 Get Recommendations")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                if let error = viewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                if viewModel.isLoading {
                    ProgressView("Fetching movie magic...")
                        .padding()
                } else {
                    List(viewModel.movies) { movie in
                        MovieRowView(movie: movie)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("🍿 MovieGPT")
        }
    }
}
