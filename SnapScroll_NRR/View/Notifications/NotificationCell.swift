//
//  NotificationCell.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

//
//import SwiftUI
//import Kingfisher
//
//struct NotificationCell: View {
//    
//    @ObservedObject var viewModel: NotificationCellViewModel
//    
//    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false }
//    
//    init(viewModel: NotificationCellViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    @State private var showPostImage = true
//    
//    var body: some View {
//        HStack{
//            if let user = viewModel.notification.user {
//                NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: user))) {
//                    KFImage(URL(string: viewModel.notification.profileImageUrl))
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 40, height: 40)
//                        .clipShape(Circle())
//                    
//                    Text(viewModel.notification.username)
//                        .font(.system(size: 14, weight: .semibold)) +
//                        Text(viewModel.notification.type.notificationMessage)
//                        .font(.system(size: 15)) +
//                        Text("\(viewModel.timestampString)").foregroundColor(.gray)
//                        .font(.system(size: 12))
//                        
//                }
//            }
//           
//            Spacer()
//            
//            if viewModel.notification.type != .follow {
//                if let post = viewModel.notification.post {
//                    NavigationLink(
//                                            destination: FeedCell(
//                                                viewModel: FeedCellViewModel(post: post),
//                                                onPostChange: {} // ✅ Dummy closure to fix the issue
//                                            )
//                                        ){
//                        KFImage(URL(string: post.imageUrl))
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 40, height: 40)
//                            .clipped()
//                    }
//                }
//            } else {
//                Button(action: {
//                    isFollowed ? viewModel.unfollow() : viewModel.follow()
//                    
//                }, label: {
//                    Text(isFollowed ? "Following" : "Follow")
//                        .font(.system(size: 15, weight: .semibold))
//                        .frame(width: 100, height: 32)
//                        .foregroundColor(isFollowed ? .black : .white)
//                        .background(isFollowed ? Color.white : Color.blue)
//                        .cornerRadius(3)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 3)
//                                .stroke(Color.gray,lineWidth:  isFollowed ? 1 : 0)
//                        )
//                })
//            }
//            
//        
//        }.padding(.horizontal)
//    }
//}
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel

    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false }

    init(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            // ✅ Profile Image
            if let user = viewModel.notification.user {
                NavigationLink(destination: ProfileView(viewModel: ProfileViewModel(user: user))) {
                    KFImage(URL(string: viewModel.notification.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    // ✅ Notification Text
                    VStack(alignment: .leading, spacing: 2) {
                        Text(viewModel.notification.username)
                            .font(.system(size: 14, weight: .semibold)) +
                        Text(viewModel.notification.type.notificationMessage)
                            .font(.system(size: 15))
                        Text("\(viewModel.timestampString)")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                }
            }

            Spacer()

            // ✅ Post Image for Notifications
            if let post = viewModel.notification.post {
                NavigationLink(
                    destination: FeedCell(
                        viewModel: FeedCellViewModel(post: post),
                        onPostChange: {}
                    )
                ) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            } else if viewModel.notification.type == .follow {
                // ✅ Follow Button
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                }) {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                }
            }
        }
        .padding(.horizontal)
    }
}
