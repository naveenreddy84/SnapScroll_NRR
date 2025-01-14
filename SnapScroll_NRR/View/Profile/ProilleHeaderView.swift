//
//  ProilleHeaderView.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 11/4/24.
//



import SwiftUI
import Kingfisher

struct ProilleHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var showEditProfile: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) { // ✅ Add spacing only where needed
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
                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                    UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
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
    }
}
