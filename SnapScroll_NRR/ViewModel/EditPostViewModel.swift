//
//  EditPostViewModel.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2025-01-14.
//

import SwiftUI
import Firebase

class EditPostViewModel: ObservableObject {
    @Published var post: Post

    init(post: Post) {
        self.post = post
    }

    func updateCaption(caption: String, completion: @escaping () -> Void) {
        guard let postId = post.id else { return }

        COLLECTIONS_POSTS.document(postId).updateData(["capttion": caption]) { error in
            if let error = error {
                print("DEBUG: Failed to update caption \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully updated caption")
            completion() // ✅ Trigger completion handler after updating
        }
    }
}
