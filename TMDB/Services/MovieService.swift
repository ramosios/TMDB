import Foundation

enum TMDBError: Error, LocalizedError {
    case missingAPIKey
    case invalidURL(String)
    case requestFailed(String)
    case decodingFailed
    case noResults(String)

    var errorDescription: String? {
        switch self {
        case .missingAPIKey: return "TMDb API key is missing."
        case .invalidURL(let title): return "Invalid URL for title: \(title)"
        case .requestFailed(let message): return "TMDb request failed: \(message)"
        case .decodingFailed: return "Failed to decode TMDb response."
        case .noResults(let title): return "No movie found for: \(title)"
        }
    }
}

struct TMDBService {
    let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String ?? ""

    func fetchMovies(for titles: [String]) async throws -> [Movie] {
        guard !apiKey.isEmpty else {
            throw TMDBError.missingAPIKey
        }

        var all: [Movie] = []

        for title in titles {
            let encoded = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encoded)") else {
                print("Invalid URL for title: \(title)")
                continue
            }

            do {
                let (data, response) = try await URLSession.shared.data(from: url)

                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    let message = String(data: data, encoding: .utf8) ?? "Unknown error"
                    print("Request failed for title \(title): \(message)")
                    continue
                }

                let result = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
                if let first = result.results.first {
                    all.append(first)
                } else {
                    print("No movie found for title: \(title)")
                }

            } catch is DecodingError {
                print("Decoding error for title: \(title)")
                continue
            } catch {
                print("Error fetching movie for title \(title): \(error.localizedDescription)")
                continue
            }
        }

        return all
    }
}
