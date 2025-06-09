//
//  CustomTabBar.swift
//  TMDB
//
//  Created by Jorge Ramos on 08/06/25.
//
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabBarItem

    var body: some View {
        HStack {
            tabButton(.discover)
            Spacer()
            tabButton(.watchlist)
            Spacer()
            tabButton(.profile)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding(.horizontal)
        .shadow(radius: 4)
    }

    private func tabButton(_ tab: TabBarItem) -> some View {
        Button(action: {
            withAnimation {
                selectedTab = tab
            }
        }) {
            VStack {
                Image(systemName: tab.icon)
                    .font(.system(size: 20, weight: .semibold))
                Text(tab.title)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == tab ? .blue : .gray)
        }
    }
}
