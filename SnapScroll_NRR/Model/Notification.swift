//
//  Notification.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 1/13/25.
//



import Firebase
import FirebaseFirestore

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    case share // ✅ Added "share" type

    var notificationMessage: String {
        switch self {
        case .like: return " liked one of your posts."
        case .comment: return " commented on one of your posts."
        case .follow: return " started following you."
        case .share: return " shared a post with you." // ✅ Added share message
        }
    }
}
