//
//  ShareView.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2025-01-14.
//
import SwiftUI
import Kingfisher

struct ShareView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @Environment(\.presentationMode) var presentationMode // Used to close the sheet
    @State private var searchText = ""
    @State private var selectedUser: User? = nil
    let post: Post

    var body: some View {
        VStack {
            // ✅ Search Bar
            SearchBar(text: $searchText, isEditing: .constant(true))
                .padding(.horizontal)

            // ✅ User List
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.filteredUsers(searchText)) { user in
                        HStack {
                            // Profile Image
                            KFImage(URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .clipShape(Circle())

                            // Username and Fullname
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(user.fullname)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                        .background(selectedUser?.id == user.id ? Color.blue.opacity(0.1) : Color.clear)
                        .onTapGesture {
                            selectedUser = user
                        }
                    }
                }
            }

            // ✅ Send Button
            if let selectedUser = selectedUser {
                Button(action: {
                    sendShareNotification(toUser: selectedUser)
                    presentationMode.wrappedValue.dismiss() // ✅ Close the sheet after sending
                }) {
                    Text("Send")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 16)
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers() // ✅ Fetch users automatically
        }
    }

    // ✅ Function to send a share notification
    func sendShareNotification(toUser user: User) {
        NotificationsViewModel.uploadNotification(
            toUid: user.id ?? "",
            type: .share,
            post: post
        )
    }
}
