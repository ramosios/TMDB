//
//  TabBarItem.swift
//  TMDB
//
//  Created by Jorge Ramos on 08/06/25.
//
import SwiftUI

enum TabBarItem: Hashable {
    case discover, watchlist, profile

    var title: String {
        switch self {
        case .discover: return "Discover"
        case .watchlist: return "Watchlist"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .discover: return "sparkles"
        case .watchlist: return "heart.fill"
        case .profile: return "person.crop.circle"
        }
    }
}
