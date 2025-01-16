//
//  ProilleHeaderView.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 11/4/24.
//


//
//import SwiftUI
//import Kingfisher
//
//struct ProilleHeaderView: View {
//    @ObservedObject var viewModel: ProfileViewModel
//    @Binding var showEditProfile: Bool
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) { // ✅ Add spacing only where needed
//            // Profile Image and Stats
//            HStack {
//                KFImage(URL(string: viewModel.user.profileImageUrl))
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 80, height: 80)
//                    .clipShape(Circle())
//                    .padding(.leading)
//
//                Spacer()
//
//                HStack(spacing: 16) {
//                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Posts")
//                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
//                    UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
//                }
//                .padding(.trailing, 32)
//            }
//
//            // Username and Bio
//            Text(viewModel.user.fullname)
//                .font(.system(size: 15, weight: .semibold))
//                .padding(.horizontal)
//
//            Text(viewModel.user.bio ?? "")
//                .font(.system(size: 15))
//                .padding(.horizontal)
//
//            ProfileActionButtonView(viewModel: viewModel)
//        }
//    }
//}

import SwiftUI
import Kingfisher

struct ProilleHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var showEditProfile: Bool
    @State private var selectedUsers: [User] = []
    @State private var selectedTitle: String = ""
    @State private var showUserList = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Profile Image and Stats
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)

                Spacer()

                HStack(spacing: 16) {
                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Posts")

                    // Followers Button
                    Button(action: {
                        viewModel.fetchFollowers { followers in
                            showUserList(title: "Followers", users: followers)
                        }
                    }) {
                        UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                    }

                    // Following Button
                    Button(action: {
                        viewModel.fetchFollowing { following in
                            showUserList(title: "Following", users: following)
                        }
                    }) {
                        UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
                    }
                }
                .padding(.trailing, 32)
            }

            // Username and Bio
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding(.horizontal)

            Text(viewModel.user.bio ?? "")
                .font(.system(size: 15))
                .padding(.horizontal)

            ProfileActionButtonView(viewModel: viewModel)
        }
        .background(
            NavigationLink(
                destination: UserFollowView(title: selectedTitle, users: selectedUsers),
                isActive: $showUserList
            ) {
                EmptyView()
            }
            .hidden()
        )
    }

    func showUserList(title: String, users: [User]) {
        selectedTitle = title
        selectedUsers = users
        showUserList = true
    }
}
