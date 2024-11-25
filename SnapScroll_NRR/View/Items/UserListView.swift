//
//  UserListView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/7/24.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.users){ _ in
                    NavigationLink(destination: ProfileView(),
                                   label:{
                        UserCell()
                            .padding(.leading)
                    })
                }
            }
            
        }
    }
}



