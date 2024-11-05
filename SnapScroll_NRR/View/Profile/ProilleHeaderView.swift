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
                    UserStatView()
                    UserStatView()
                    UserStatView()
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
                
                Button(action:{} , label: {
                    Text("Edit Profile")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 360, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray,lineWidth:  1)
                        )
                })
                
                Spacer()
            }.padding(.top)
        }
    }
}


struct UserStatView: View{
    var body: some View{
        VStack{
            Text("2")
                .font(.system(size: 15, weight: .semibold))
            
            Text("Followers")
                .font(.system(size: 15))
        }
        .frame(width: 80, alignment: .center)
    }
}


struct ProilleHeaderView_Previews: PreviewProvider {
    static var previews: some View{
        ProilleHeaderView()
    }
}
