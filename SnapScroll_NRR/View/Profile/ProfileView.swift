//
//  ProfileView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 32){
                ProilleHeaderView()
                
                
            }.padding(.top)
        }
    }
}

#Preview {
    ProfileView()
}
