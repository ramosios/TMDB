//
//  ContentView.swift
//  TMDB
//
//  Created by Jorge Ramos on 04/06/25.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabBarItem = .discover

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                MovieListView()
                    .opacity(selectedTab == .discover ? 1 : 0)
                    .allowsHitTesting(selectedTab == .discover)

                FavoritesView()
                    .opacity(selectedTab == .watchlist ? 1 : 0)
                    .allowsHitTesting(selectedTab == .watchlist)

                ProfileView()
                    .opacity(selectedTab == .profile ? 1 : 0)
                    .allowsHitTesting(selectedTab == .profile)
            }

            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
