//
//  OpenAiService.swift
//  TMDB
//
//  Created by Jorge Ramos on 03/06/25.
//
import Foundation
struct OpenAIService {
    let apiKey = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String ?? ""

    func fetchMovieTitles(prompt: String) async throws -> [String] {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": "Recommend 5 movies for: \(prompt)"]],
            "temperature": 0.7
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)

        let rawText = response.choices.first?.message.content ?? ""
        return rawText
            .components(separatedBy: "\n")
            .compactMap { $0.components(separatedBy: ". ").last }
            .filter { !$0.isEmpty }
    }
}
