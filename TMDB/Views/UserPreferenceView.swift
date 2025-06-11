//
//  UserPreferenceView.swift
//  TMDB
//
//  Created by Jorge Ramos on 10/06/25.
import SwiftUI

struct UserPreferenceView: View {
    @StateObject private var preferencesVM = UserPreferencesViewModel()

    let questions = [
        "What's your favorite genre?",
        "How often do you watch movies?",
        "Do you prefer action or drama?"
    ]

    let options = [
        ["","Action", "Comedy", "Drama", "Sci-Fi"],
        ["","Daily", "Weekly", "Monthly"],
        ["","Action", "Drama"]
    ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Preferences")) {
                    ForEach(0..<questions.count, id: \.self) { index in
                        Picker(questions[index], selection: Binding(
                            get: {
                                let current = preferencesVM.selectedAnswers[index]
                                return options[index].contains(current) ? current : options[index][0] // fallback
                            },
                            set: { preferencesVM.selectedAnswers[index] = $0 }
                        )) {
                            ForEach(options[index], id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }

                Button("Save Preferences") {
                    preferencesVM.saveAnswers()
                }
            }
            .navigationTitle("Movie Preferences")
            .onAppear {
                preferencesVM.loadAnswers()
            }
        }
    }
}
