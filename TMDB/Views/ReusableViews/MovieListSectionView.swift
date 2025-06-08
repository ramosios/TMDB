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
        List(movies) { movie in
            MovieRowView(movie: movie)
        }
        .listStyle(.plain)
    }
}
