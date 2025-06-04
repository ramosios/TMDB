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

                if let error = viewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    MovieListSection(movies: viewModel.movies)
                }
            }
            .navigationTitle("MovieGPT")
            .padding()
        }
    }
}
