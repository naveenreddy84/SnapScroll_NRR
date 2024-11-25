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
            
            print(self.users)
            }
            
         
            
            
        }
    }
    


