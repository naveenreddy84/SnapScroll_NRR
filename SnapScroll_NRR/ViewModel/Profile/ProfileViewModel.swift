//
//  ProfileViewModel.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/26/24.
//

import SwiftUI
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    func fetchUserData() {
        guard let uid = user.id else { return }
        COLLECTIONS_USERS.document(uid).getDocument { snapshot, _ in
            if let userData = try? snapshot?.data(as: User.self) {
                DispatchQueue.main.async {
                    self.user = userData
                    self.fetchUserStats()
                    self.checkIfUserIsFollowed()
                }
            } else {
                print("DEBUG: Failed to fetch user data")
            }
        }
    }
    
    func follow() {
        guard let uid = user.id else { return }
        
        UserService.follow(uid: uid) { _ in
            NotificationsViewModel.uploadNotification(toUid: uid, type: .follow)
            self.user.isFollowed = true
            
            // ✅ Refresh user stats after following
            self.fetchUserStats()
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        
        UserService.unfollow(uid: uid) { _ in
            self.user.isFollowed = false
            
            // ✅ Refresh user stats after unfollowing
            self.fetchUserStats()
        }
    }
    
    func checkIfUserIsFollowed() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.checkIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        
        COLLECTIONS_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
            let following = snapshot?.documents.count ?? 0
            
            COLLECTIONS_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
                let followers = snapshot?.documents.count ?? 0
                
                COLLECTIONS_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
                    let posts = snapshot?.documents.count ?? 0
                    
                    self.user.stats = UserStats(following: following, posts: posts, followers: followers)
                }
            }
        }
    }
    
    func fetchFollowers(completion: @escaping ([User]) -> Void) {
            Firestore.firestore()
                .collection("followers")
                .document(user.id ?? "")
                .collection("user-followers")
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else {
                        completion([])
                        return
                    }

                    let userIds = documents.map { $0.documentID }
                    let group = DispatchGroup()
                    var followers: [User] = []

                    for userId in userIds {
                        group.enter()
                        Firestore.firestore()
                            .collection("users")
                            .document(userId)
                            .getDocument { userSnapshot, _ in
                                if let userData = try? userSnapshot?.data(as: User.self) {
                                    followers.append(userData)
                                }
                                group.leave()
                            }
                    }

                    group.notify(queue: .main) {
                        completion(followers)
                    }
                }
        }

        func fetchFollowing(completion: @escaping ([User]) -> Void) {
            Firestore.firestore()
                .collection("following")
                .document(user.id ?? "")
                .collection("user-following")
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else {
                        completion([])
                        return
                    }

                    let userIds = documents.map { $0.documentID }
                    let group = DispatchGroup()
                    var following: [User] = []

                    for userId in userIds {
                        group.enter()
                        Firestore.firestore()
                            .collection("users")
                            .document(userId)
                            .getDocument { userSnapshot, _ in
                                if let userData = try? userSnapshot?.data(as: User.self) {
                                    following.append(userData)
                                }
                                group.leave()
                            }
                    }

                    group.notify(queue: .main) {
                        completion(following)
                    }
                }
        }
}
