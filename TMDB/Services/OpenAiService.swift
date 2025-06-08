//
//  OpenAiService.swift
//  TMDB
//
//  Created by Jorge Ramos on 03/06/25.
//
import Foundation

enum OpenAIError: Error, LocalizedError {
    case missingAPIKey
    case invalidResponse
    case decodingFailed
    case emptyChoices
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .missingAPIKey: return "Missing OpenAI API key."
        case .invalidResponse: return "Invalid response from OpenAI."
        case .decodingFailed: return "Failed to decode OpenAI response."
        case .emptyChoices: return "No suggestions received."
        case .serverError(let message): return "OpenAI server error: \(message)"
        }
    }
}

struct OpenAIService {
    let apiKey = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String ?? ""

    func fetchMovieTitles(prompt: String, excluding moviesToAvoid: [Movie]) async throws -> [String] {
        guard !apiKey.isEmpty else {
            throw OpenAIError.missingAPIKey
        }

        let avoidList = moviesToAvoid.map(\.title).filter { !$0.isEmpty }
        let avoidText = avoidList.isEmpty ? "" :
            "\nAvoid these movies as they've already been watched or added to my watchlist: " +
            avoidList.prefix(30).joined(separator: ", ")

        let fullPrompt = "Recommend 5 movies for the following prompt: \(prompt).\(avoidText)"

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": fullPrompt]],
            "temperature": 0.7
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResp = response as? HTTPURLResponse, !(200...299).contains(httpResp.statusCode) {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw OpenAIError.serverError(message)
        }

        let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        guard let text = decoded.choices.first?.message.content else {
            throw OpenAIError.emptyChoices
        }

        return text
            .components(separatedBy: "\n")
            .compactMap { $0.components(separatedBy: ". ").last }
            .filter { !$0.isEmpty }
    }
}
