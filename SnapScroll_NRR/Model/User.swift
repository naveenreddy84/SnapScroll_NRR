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
    let profileImageUrl: String
    let fullName: String
    @DocumentID var id: String?
}
