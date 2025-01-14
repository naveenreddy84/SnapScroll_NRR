//
//  PostGridViewModel.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-12-21.
//

import SwiftUI

enum PostGridConfiguration {
    case explore
    case profile(String)
}

class PostGridViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    let config: PostGridConfiguration
    
    // ✅ Initializer that automatically fetches posts based on the config
    init(config: PostGridConfiguration) {
        self.config = config
        fetchPosts()
    }
    
    // ✅ Fetch posts based on the configuration type
    func fetchPosts() {
        switch config {
        case .explore:
            fetchExplorePosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    // ✅ Fetch explore posts ordered by likes
    func fetchExplorePosts() {
        COLLECTIONS_POSTS.order(by: "likes", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap { try? $0.data(as: Post.self) }
        }
    }
    
    // ✅ Fetch posts for a specific user, ordered by timestamp
    func fetchUserPosts(forUid uid: String) {
        COLLECTIONS_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap { try? $0.data(as: Post.self) }
            self.posts = posts.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
        }
    }
}
