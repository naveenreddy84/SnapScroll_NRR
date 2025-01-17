//
//  FeedViewModel.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 12/9/24.
//

import SwiftUI

class FeedViewModel: ObservableObject{
    @Published var posts = [Post]()
    
    init(){
        fetchPosts()
    }
    
    func fetchPosts(){
        COLLECTIONS_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
            
        }
    }
    
    func refreshPosts() {
           self.posts.removeAll()
           fetchPosts()
       }
}
