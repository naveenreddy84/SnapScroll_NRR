//
//  UserListView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/7/24.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    var users : [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(users){ user in
                    NavigationLink(destination: LazyView(ProfileView(viewModel: ProfileViewModel(user: user))),
                                   label:{
                        UserCell(user : user)
                            .padding(.leading)
                    })
                }
            }
            
        }
    }
}



