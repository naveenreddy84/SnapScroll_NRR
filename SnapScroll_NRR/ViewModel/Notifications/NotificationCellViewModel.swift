//
//  NotificationCellViewModel.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 1/13/25.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .year]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    func follow() {
        print("DEBUG: Follow User:")
        
        UserService.follow(uid: notification.uid) { _ in
            
            NotificationsViewModel.uploadNotification(toUid: self.notification.uid, type: .follow)
            
            self.notification.isFollowed = true
            
            print("Successfully followed \(self.notification.username)")
            
        }
    }
    
    func unfollow() {
        
        print("DEBUG: Unfollow User:")
        
        UserService.unfollow(uid: notification.uid) { _ in
            
            self.notification.isFollowed = false
            
            print("Successfully unfollowed \(self.notification.username)")
            
        }
        
    }
    
    func checkIfUserIsFollowed() {
        
        guard notification.type == .follow else { return }
        
        UserService.checkIfUserIsFollowed(uid: notification.uid){ isFollowed in
            self.notification.isFollowed = isFollowed
            
        }
        
    }
    
    func fetchNotificationPost() {
        guard let postId = notification.postId else  { return }
        
        COLLECTIONS_POSTS.document(postId).getDocument { snapshot, _ in
            self.notification.post = try? snapshot?.data(as: Post.self)
        }
        
    }
    
    func fetchNotificationUser() {
        COLLECTIONS_USERS.document(notification.uid).getDocument { snapshot, _ in
            self.notification.user = try? snapshot?.data(as: User.self)
            print("DEBUG: User is \(self.notification.user?.username)")
            
        }
    }
}
