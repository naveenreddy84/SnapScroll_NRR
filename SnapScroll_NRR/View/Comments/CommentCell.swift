//
//  CommentCell.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 1/8/25.
//

import SwiftUI

struct CommentCell: View {
    var body: some View {
        HStack{
            Image("beach")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text("ravali").font(.system(size: 14, weight: .semibold)) +
            Text(" comment text ").font(.system(size: 14))
            
            Spacer()
            
            Text("2m")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommentCell()
}
