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
