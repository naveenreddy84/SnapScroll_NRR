//
//  User.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-11-24.
//

import FirebaseFirestore

struct User : Identifiable, Decodable{
    let username: String
    let email: String
    var profileImageUrl: String
    var fullname: String
    @DocumentID var id: String?
    var bio: String?
    var stats: UserStats?
    var isFollowed: Bool? = false

    
    var isCurrentUser: Bool {
        return AuthViewModel.shared.userSession?.uid == id
    }
}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
    
}


