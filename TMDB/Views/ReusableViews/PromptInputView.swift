//
//  PromptInputView.swift
//  TMDB
//
//  Created by Jorge Ramos on 08/06/25.
//
import SwiftUI

struct PromptInputView: View {
    @Binding var prompt: String
    let onSubmit: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            TextEditor(text: $prompt)
                .frame(height: 100)
                .padding(8)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))

            Button(action: onSubmit) {
                Label("🎬 Get Recommendations", systemImage: "sparkles")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
