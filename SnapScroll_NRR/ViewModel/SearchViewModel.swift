//
//  SearchViewModel.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-11-25.
//

import SwiftUI


class SearchViewModel: ObservableObject {
    @Published var users = [User]()
  
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers(){
        
        COLLECTIONS_USERS.getDocuments{ snapshot, _ in
            
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({try? $0.data(as: User.self) })
            
            
        }
    }
    
        
//        func filteredUsers(_ query: String) -> [User] {
//            let loweredQuery = query.lowercased()
//            return users.filter({ $0.fullname.lowercased().contains(loweredQuery)  ||  $0.username.lowercased().contains(loweredQuery)})
//        }
    
    // ✅ Return all users when the query is empty, otherwise filter
        func filteredUsers(_ query: String) -> [User] {
            let loweredQuery = query.lowercased()
            let currentUserId = AuthViewModel.shared.currentUser?.id ?? ""

            if query.isEmpty {
                // ✅ Return all users except the logged-in user if no search text is entered
                return users.filter { $0.id != currentUserId }
            } else {
                // ✅ Filter users by username or fullname
                return users.filter {
                    ($0.fullname.lowercased().contains(loweredQuery) ||
                     $0.username.lowercased().contains(loweredQuery)) &&
                    $0.id != currentUserId
                }
            }
        }
        
        
    }
    
    

