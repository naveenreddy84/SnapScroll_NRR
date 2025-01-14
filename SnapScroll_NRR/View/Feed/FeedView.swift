//
//  FeedView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post), onPostChange: {
                        viewModel.refreshPosts() // ✅ Refresh the feed after editing/deleting
                    })
                }
            }
            .padding(.top)
        }
        .onAppear {
            viewModel.fetchPosts() // ✅ Fetch posts when the view appears
        }
    }
}

