//
//  FeedCellViewModel.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 12/22/24.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    //    @Published var post: Post
    //    @Published var user: User? // ✅ Keep track of the user data
    //
    //    var likeString: String {
    //        let label = post.likes == 1 ? "like" : "likes"
    //        return "\(post.likes) \(label)"
    //    }
    //
    //    var timestampString: String {
    //        let formatter = DateComponentsFormatter()
    //        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .year]
    //        formatter.maximumUnitCount = 1
    //        formatter.unitsStyle = .abbreviated
    //        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    //    }
    //
    //    init(post: Post) {
    //        self.post = post
    //        checkIfUserLikedPost()
    //        fetchPostUser()
    //    }
    @Published var post: Post
    @Published var user: User? // ✅ Keep track of the user data
    @Published var commentCount = 0 // ✅ New property to track comment count
    
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .year]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
        fetchPostUser()
        fetchCommentCount() // ✅ Fetch comment count
    }
    
    func fetchCommentCount() {
        guard let postId = post.id else { return }
        let query = COLLECTIONS_POSTS.document(postId).collection("post-comments")
        query.addSnapshotListener { snapshot, _ in
            self.commentCount = snapshot?.documents.count ?? 0
        }
    }
    
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTIONS_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { _ in
                COLLECTIONS_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { _ in
                        COLLECTIONS_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
                        
                        NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid, type: .like, post: self.post)
                        
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
    }
    
    func unlike() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTIONS_POSTS.document(postId).collection("post-likes")
            .document(uid).delete { _ in
                COLLECTIONS_USERS.document(uid).collection("user-likes")
                    .document(postId).delete { _ in
                        COLLECTIONS_POSTS.document(postId).updateData(["likes": self.post.likes - 1])
                        
                        self.post.didLike = false
                        self.post.likes -= 1
                    }
            }
    }
    
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTIONS_USERS.document(uid).collection("user-likes").document(postId)
            .getDocument { snapshot, _ in
                guard let didLike = snapshot?.exists else { return }
                self.post.didLike = didLike
            }
    }
    
    func fetchPostUser() {
        COLLECTIONS_USERS.document(post.ownerUid).getDocument { snapshot, _ in
            DispatchQueue.main.async {
                self.user = try? snapshot?.data(as: User.self)
            }
        }
    }
    // ✅ Delete Post Function with Completion Handler
    func deletePost(completion: @escaping () -> Void) {
        guard let postId = post.id else { return }

        COLLECTIONS_POSTS.document(postId).delete { error in
            if let error = error {
                print("DEBUG: Failed to delete post \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully deleted post")
            completion() // ✅ Trigger completion handler after deleting
        }
    }
}
