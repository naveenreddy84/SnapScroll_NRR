//
//  UserCell.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/7/24.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack{
            //image
            Image("beach")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
//                .cornerRadius(24)
            
            //vstack -> username, fullname
            VStack(alignment: .leading){
                Text("ravali")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Ravali Gottam")
                    .font(.system(size: 14))
            }
            Spacer()
        }
    }
}

#Preview {
    UserCell()
}
