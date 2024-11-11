//
//  PostGridView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/7/24.
//

import SwiftUI

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width/3
    
    
    var body: some View {
        LazyVGrid(columns: items,spacing: 2, content: {
            ForEach(0 ..< 10){ _ in
                NavigationLink(destination: FeedView(), label: {
                    Image("beach")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                })
                
            }
        })
    }
}

#Preview {
    PostGridView()
}
