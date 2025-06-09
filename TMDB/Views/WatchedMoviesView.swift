//
//  WatchedMoviesView.swift
//  TMDB
//
//  Created by Jorge Ramos on 05/06/25.
//
import SwiftUI

struct WatchedMoviesView: View {
    @EnvironmentObject var watched: WatchedViewModel

    var body: some View {
        MovieListSection(movies:watched.watched)
            .navigationTitle("Watched")
    }
}
