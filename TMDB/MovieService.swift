import Foundation

struct TMDBService {
    let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String ?? ""

    func fetchMovies(for titles: [String]) async throws -> [Movie] {
        var all: [Movie] = []
        for title in titles {
            let encoded = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encoded)") else { continue }
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
            if let first = result.results.first {
                all.append(first)
            }
        }
        return all
    }
}
