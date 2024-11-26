//
//  ProilleHeaderView.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 11/4/24.
//



import SwiftUI
import Kingfisher

struct ProilleHeaderView: View {
    
    let user: User
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16){
                    UserStatView(value: 1, title: "Post")
                    UserStatView(value: 2, title: "Followers")
                    UserStatView(value: 4, title: "Following")
                }.padding(.trailing, 32)

                
            }
            
            Text(user.fullname)
                .font(.system(size: 15 , weight: .semibold))
                .padding([.leading, .top])
            
            Text("Montreal | Student")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 1)
            
            HStack {
                Spacer()
                
                ProfileActionButtonView(isCurrentUser: user.isCurrentUser)
                
                Spacer()
            }.padding(.top)
        }
    }
}





