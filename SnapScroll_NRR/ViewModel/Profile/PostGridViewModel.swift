//
//  PostGridViewModel.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-12-21.
//

import SwiftUI


enum PostGridConfiguration{
    case explore
    case profile(String)
}


class PostGridViewModel: ObservableObject {
    
  @Published var posts: [Post] = []
    let config : PostGridConfiguration
    
    init(config : PostGridConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config : PostGridConfiguration){
        switch config {
        case .explore:
            fetchExplorePosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    func fetchExplorePosts() {
        COLLECTIONS_POSTS.getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
        
        }
    }
    
    
    func fetchUserPosts(forUid uid: String){
        COLLECTIONS_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
        }
    }
}
