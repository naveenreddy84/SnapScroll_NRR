//
//  ProilleHeaderView.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 11/4/24.
//



import SwiftUI

struct ProilleHeaderView: View {
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Image("batman")
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
            
            Text("Rajesh Begari")
                .font(.system(size: 15 , weight: .semibold))
                .padding([.leading, .top])
            
            Text("Montreal | Student")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 1)
            
            HStack {
                Spacer()
                
                ProfileActionButtonView()
                
                Spacer()
            }.padding(.top)
        }
    }
}




struct ProilleHeaderView_Previews: PreviewProvider {
    static var previews: some View{
        ProilleHeaderView()
    }
}
