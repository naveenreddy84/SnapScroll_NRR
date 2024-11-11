//
//  UserListView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/7/24.
//

import SwiftUI

struct UserListView: View {
    var body: some View {
        ScrollView{
            
            LazyVStack{
                ForEach(0 ..< 20){ _ in
                    NavigationLink(destination: ProfileView(), label:{
                        UserCell()
                            .padding(.leading)
                    })
                }
            }
            
        }
    }
}

#Preview {
    UserListView()
}
