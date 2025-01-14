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
    @State private var showEditPostView = false
    var onPostChange: () -> Void // ✅ Completion handler for post changes
    @State private var showShareView = false

    var didLike: Bool { return viewModel.post.didLike ?? false }

    init(viewModel: FeedCellViewModel, onPostChange: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onPostChange = onPostChange
    }

    var body: some View {
        VStack(alignment: .leading) {
            // ✅ User Info
            HStack {
                if let user = viewModel.user {
                    NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: user))) {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())

                        Text(user.username)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
                
                // ✅ Show Edit/Delete Buttons Only for the Post Owner
                if viewModel.post.ownerUid == AuthViewModel.shared.userSession?.uid {
                    HStack(spacing: 10) {
                        // Edit Button
                        Button(action: {
                            showEditPostView.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                        }
                        .sheet(isPresented: $showEditPostView) {
                            EditPostView(post: viewModel.post) {
                                onPostChange() // ✅ Trigger refresh after editing
                            }
                        }

                        // Delete Button
                        Button(action: {
                            viewModel.deletePost {
                                onPostChange() // ✅ Trigger refresh after deleting
                            }
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)

            // ✅ Post Image
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipped()

            // ✅ Action Buttons
            HStack(spacing: 16) {
                Button(action: {
                    didLike ? viewModel.unlike() : viewModel.like()
                }) {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(didLike ? .red : .black)
                }

                NavigationLink(destination: CommentsView(post: viewModel.post)) {
                                                        HStack {
                                                            Image(systemName: "bubble.right")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 20, height: 20)
                                                                .foregroundColor(.black)
                                                            if viewModel.commentCount > 0 {
                                                                // ✅ Comment Count
                                                                Text("\(viewModel.commentCount ?? 0)")
                                                                    .font(.system(size: 14))
                                                                    .foregroundColor(.gray)
                                                            }
                                                        }
                }
                
                
                Button(action: {
                                    showShareView.toggle()
                                }) {
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                }
                                .sheet(isPresented: $showShareView) {
                                    ShareView(post: viewModel.post)
                                }
            }
            .padding(.horizontal, 8)
            
            

            // ✅ Likes Count
            Text(viewModel.likeString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 8)

            // ✅ Caption
            HStack {
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold)) +
                Text(" \(viewModel.post.capttion)")
                    .font(.system(size: 15))
            }
            .padding(.horizontal, 8)
            .fixedSize(horizontal: false, vertical: true)

            // ✅ Timestamp
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
        }
        .padding(.horizontal)
    }
}
