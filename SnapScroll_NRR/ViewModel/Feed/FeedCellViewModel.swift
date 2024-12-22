//
//  FeedCellViewModel.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 12/22/24.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func like(){
        
        print("Like post")
        
    }
    
    func unlike(){
        print("UnLike post")
    }
    
    func checkIfUserLikedPost(){
        
    }
}
