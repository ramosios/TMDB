import Foundation

struct Movie: Identifiable, Decodable, Encodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let popularity: Double?
    let voteAverage: Double?
    let releaseDate: String?
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

struct MovieSearchResponse: Decodable {
    let results: [Movie]
}

extension Movie {
    var formattedVoteAverage: String {
        if let voteAverage = voteAverage {
            return String(format: "%.1f", voteAverage)
        } else {
            return "-"
        }
    }
    var formattedReleaseDate: String {
        guard let releaseDate = releaseDate else { return "-" }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: releaseDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium // e.g. "Mar 24, 2023"
            return outputFormatter.string(from: date)
        }
        return releaseDate
    }
}
