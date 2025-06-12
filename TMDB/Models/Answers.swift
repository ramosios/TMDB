//
//  Answers.swift
//  TMDB
//
//  Created by Jorge Ramos on 10/06/25.
//
import Foundation

struct UserPreferences: Codable {
    var answers: [String]
}

func formatPreferences(_ preferences: [String]) -> String {
    let transformed = preferences.enumerated().compactMap { index, value in
        switch index {
        case 0: return "I like \(value.lowercased()) movies"
        case 1: return "I usually watch movies \(value.lowercased())"
        case 2: return "I prefer \(value.lowercased())"
        default: return nil
        }
    }

    return transformed.isEmpty ? "" :
        "\nTake into account these preferences: " + transformed.joined(separator: ", ") + "."
}
