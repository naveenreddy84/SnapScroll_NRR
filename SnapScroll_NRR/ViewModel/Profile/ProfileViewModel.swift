//
//  ProfileViewModel.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/26/24.
//

import SwiftUI
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
    }
    
    func follow() {
        print("DEBUG: Follow User:")
        
        guard let uid = user.id else { return }
        
        UserService.follow(uid: uid) { _ in
            
            self.user.isFollowed = true
            
            print("Successfully followed \(self.user.username)")
            
        }
    }
    
    func unfollow() {
        
        print("DEBUG: Unfollow User:")
        
        guard let uid = user.id else { return }
        
        UserService.unfollow(uid: uid) { _ in
            
            self.user.isFollowed = false
            
            print("Successfully unfollowed \(self.user.username)")
            
        }
        
    }
    
    func checkIfUserIsFollowed() {
        
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.checkIfUserIsFollowed(uid: uid){ isFollowed in
            self.user.isFollowed = isFollowed
            
        }
        
    }
}
