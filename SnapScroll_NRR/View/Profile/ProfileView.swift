//
//  ProfileView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false

    var body: some View {
        ScrollView {
            VStack(spacing: 5) { // ✅ Remove spacing between elements
                // Profile Header
                ProilleHeaderView(viewModel: viewModel, showEditProfile: $showEditProfile)

                // Post Grid
                PostGridView(config: .profile(viewModel.user.id ?? ""))
            }
        }
        .navigationTitle(viewModel.user.username)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showEditProfile) {
            EditProfileView(user: $viewModel.user)
        }
        .onAppear {
                    // ✅ Fetch the latest user data from Firestore
                    viewModel.fetchUserData()
        }
    }
}


