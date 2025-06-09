//
//  MovieListSectionView.swift
//  TMDB
//
//  Created by Jorge Ramos on 08/06/25.
//
import SwiftUI

struct MovieListSection: View {
    let movies: [Movie]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(movies) { movie in
                    NavigationLink(destination:
                        MovieDetailView(movie: movie)
                    ) {
                        MovieRowView(movie: movie)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(PlainButtonStyle()) 
                }
            }
        }
    }
}
