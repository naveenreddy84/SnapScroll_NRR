//
//  Post.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 12/9/24.
//

import FirebaseFirestore
//import Firebase


struct Post: Identifiable, Decodable{
    @DocumentID var id: String?
    let ownerUid: String
    let username: String
    let captiion: String
    let likes:  Int
    let imageUrl: String
    let timestamp: Timestamp
    let ownerImageUrl: String
    let ownerUsername: String
}


