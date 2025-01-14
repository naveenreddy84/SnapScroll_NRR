//
//  FeedCell.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike: Bool { return viewModel.post.didLike ?? false}
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            //user info
            HStack{
                KFImage(URL(string: viewModel.post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
                    
            }
            
            //post image
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            //action buttons - like, comment, share
            HStack(spacing: 16){
                Button(action: {
                    didLike ? viewModel.unlike() : viewModel.like()
                }, label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? .red : .black)
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
            Text(viewModel.likeString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            
            //caption
            HStack{
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold)) +
                Text(" \(viewModel.post.capttion)")
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

