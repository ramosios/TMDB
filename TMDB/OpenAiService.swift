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

    func fetchMovieTitles(prompt: String) async throws -> [String] {
        guard !apiKey.isEmpty else {
            throw OpenAIError.missingAPIKey
        }

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": "Only respond with movie title for prompt: \(prompt)"]],
            "temperature": 0.7
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResp = response as? HTTPURLResponse, !(200...299).contains(httpResp.statusCode) {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw OpenAIError.serverError(message)
        }

        do {
            let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            guard let content = decoded.choices.first?.message.content else {
                throw OpenAIError.emptyChoices
            }

            return content
                .components(separatedBy: "\n")
                .compactMap { $0.components(separatedBy: ". ").last }
                .filter { !$0.isEmpty }

        } catch {
            throw OpenAIError.decodingFailed
        }
    }
}
