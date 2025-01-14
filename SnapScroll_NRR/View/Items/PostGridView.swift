//
//  PostGridView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/7/24.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width/3
    
    let config: PostGridConfiguration
    @ObservedObject var viewModel : PostGridViewModel
    
    init(config: PostGridConfiguration) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    
    var body: some View {
        LazyVGrid(columns: items,spacing: 2, content: {
            ForEach(viewModel.posts){ post in
                NavigationLink(destination: FeedView(), label: {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                })
                
            }
        })
    }
}


