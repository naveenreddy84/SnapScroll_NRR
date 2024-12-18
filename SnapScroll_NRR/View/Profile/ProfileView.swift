//
//  ProfileView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct ProfileView: View {
    
    let user : User

    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }

    
    var body: some View {
        ScrollView{
            VStack(spacing: 32){

                ProilleHeaderView(viewModel: viewModel)
                PostGridView()

                
            }.padding(.top)
        }
    }
}


