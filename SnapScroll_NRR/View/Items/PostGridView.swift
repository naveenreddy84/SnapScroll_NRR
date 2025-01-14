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
    private let width = UIScreen.main.bounds.width / 3
    
    let config: PostGridConfiguration
    @ObservedObject var viewModel: PostGridViewModel
    
    // ✅ Corrected the initializer with 'config' label
    init(config: PostGridConfiguration) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config) // ✅ Fixed label
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2) {
            ForEach(viewModel.posts) { post in
                NavigationLink(
                    destination: FeedCell(
                        viewModel: FeedCellViewModel(post: post),
                        onPostChange: {
                            viewModel.fetchPosts() // ✅ Refresh posts after changes
                        }
                    )
                ) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                }
            }
        }
    }
}


