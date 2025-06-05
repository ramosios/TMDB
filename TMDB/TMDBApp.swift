//
//  TMDBApp.swift
//  TMDB
//
//  Created by Jorge Ramos on 17/05/25.
//

import SwiftUI

@main
struct TMDBApp: App {
    @StateObject private var favorites = FavoritesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites) 
        }
    }
}
