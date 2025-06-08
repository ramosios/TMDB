import SwiftUI

struct PromptInputView: View {
    @Binding var prompt: String
    let onSubmit: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Tell us what you're in the mood for:")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: 120)

                TextEditor(text: $prompt)
                    .padding(8)
                    .frame(height: 120)
                    .background(Color.clear)
            }

            Button(action: onSubmit) {
                Label("Get Movie Recommendations", systemImage: "sparkles.tv.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}
