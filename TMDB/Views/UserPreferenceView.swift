//
//  UserPreferenceView.swift
//  TMDB
//
//  Created by Jorge Ramos on 10/06/25.
import SwiftUI

struct UserPreferenceView: View {
    @StateObject private var preferencesVM = UserPreferencesViewModel()

    let questions = [
        "Do you prefer fast-paced or slow-burn stories??",
        "How often do you watch movies?",
        "Are you more into new releases or older films?"
    ]

    let options = [
        ["","fast-paced", "slow-burn"],
        ["","Daily", "Weekly", "Monthly"],
        ["","new releases", "older films"]
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
