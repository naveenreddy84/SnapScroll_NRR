//
//  NotificationCell.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct NotificationCell: View {
    
    @State private var showPostImage = true
    
    var body: some View {
        HStack{
            Image("beach")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text("Beaching")
                .font(.system(size: 14, weight: .semibold)) +
            Text(" liked one of your posts")
                .font(.system(size: 15))
            
            Spacer()
            
            if showPostImage{
                Image("beach")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Button(action: {}, label: {
                    Text("Follow")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .font(.system(size: 14, weight: .semibold))
                })
            }
            
        
        }.padding(.horizontal)
    }
}

#Preview {
    NotificationCell()
}
