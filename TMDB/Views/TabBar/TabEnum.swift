//
//  TabEnum.swift
//  TMDB
//
//  Created by Jorge Ramos on 08/06/25.
//
enum Tab: String, CaseIterable {
    case home, watchlist, watched, profile

    var icon: String {
        switch self {
        case .home: return "house"
        case .watchlist: return "heart"
        case .watched: return "checkmark.circle"
        case .profile: return "person"
        }
    }

    var label: String {
        rawValue.capitalized
    }
}
