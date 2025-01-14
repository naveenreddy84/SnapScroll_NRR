//
//  Cooment.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 1/8/25.
//

import Firebase
import FirebaseFirestore

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let postOwnerUid: String
    let profileImageUrl: String
    let commentText: String
    let timestamp: Timestamp
    let uid: String
}
