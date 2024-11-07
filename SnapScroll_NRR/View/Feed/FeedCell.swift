//
//  FeedCell.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading){
            
            //user info
            HStack{
                Image("beach")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text("ravali")
                    .font(.system(size: 14, weight: .semibold))
                    
            }
            
            //post image
            Image("beach")
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            //action buttons - like, comment, share
            HStack(spacing: 16){
                Button(action: {}, label: {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(5)
                })
                
                Button(action: {}, label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .font(.system(size: 20))
                })
                
                Button(action: {}, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .font(.system(size: 20))
                })
            }.foregroundColor(.black)
            
            //likes message
            Text("3 likes")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            
            //caption
            HStack{
                Text("Beaching")
                    .font(.system(size: 14, weight: .semibold)) +
                Text(" Live in the moment because this too shall pass, have fun and love.")
                    .font(.system(size: 15))
            }.padding(.horizontal, 8)
            
            Text("2d")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.top, -2)
                .padding(.leading, 8)
            
        }.padding()
    }
}

#Preview {
    FeedCell()
}
