//
//  UserService.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/26/24.
//

import Firebase

typealias FireStoreCompletion = ((Error?) -> Void)?

struct UserService{
    
    static func follow(uid: String, completion: (( Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTIONS_FOLLOWING.document(currentUid)
            .collection("user-following").document(uid).setData([:]) { _ in
                
                COLLECTIONS_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).setData([:], completion: completion)
                
            }
    }
    
    static func unfollow(uid: String, completion: (( Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTIONS_FOLLOWING.document(currentUid)
            .collection("user-following").document(uid).delete { _ in
                COLLECTIONS_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).delete(completion: completion)
                    
            }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTIONS_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).getDocument { snapshot, _ in
                
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
                
                
            }
        
        
    }
}
