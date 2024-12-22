//
//  FeedCellViewModel.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 12/22/24.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    init(post: Post) {
        self.post = post
    }
    
    func like(){
        
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTIONS_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { _ in
                COLLECTIONS_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { _ in
                        
                        COLLECTIONS_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
                        
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
        
    }
    
    func unlike(){
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
        
        print("UnLike post")
    }
    
    func checkIfUserLikedPost(){
        
        
    }
}
