//
//  EditPostView.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2025-01-14.
//

import SwiftUI

struct EditPostView: View {
    @ObservedObject var viewModel: EditPostViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var caption = ""
    var onComplete: () -> Void // ✅ Completion handler

    init(post: Post, onComplete: @escaping () -> Void) {
        self.viewModel = EditPostViewModel(post: post)
        self.onComplete = onComplete
    }

    var body: some View {
        VStack {
            TextField("Edit Caption", text: $caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                viewModel.updateCaption(caption: caption) {
                    onComplete() // ✅ Notify completion
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Save Changes")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top)
            }

            Spacer()
        }
        .onAppear {
            caption = viewModel.post.capttion
        }
    }
}
