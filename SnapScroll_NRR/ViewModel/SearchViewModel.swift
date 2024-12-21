//
//  SearchViewModel.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-11-25.
//

import SwiftUI


class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var posts = [Post]()
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers(){
        
        COLLECTIONS_USERS.getDocuments{ snapshot, _ in
            
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({try? $0.data(as: User.self) })
            
            
        }
    }
        
        
        
        func filteredUsers(_ query: String) -> [User] {
            let loweredQuery = query.lowercased()
            return users.filter({ $0.fullname.lowercased().contains(loweredQuery)  ||  $0.username.lowercased().contains(loweredQuery)})
        }
        
        
    }


