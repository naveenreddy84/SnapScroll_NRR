import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false

    var body: some View {
        if viewModel.user.isCurrentUser {
            // ✅ Edit Profile Button
            Button(action: { showEditProfile.toggle() }) {
                Text("Edit Profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(user: $viewModel.user)
            }
        } else {
            // ✅ Follow and Message Buttons (Aligned Properly)
            HStack(spacing: 12) {
                Button(action: {
                    viewModel.user.isFollowed ?? false ? viewModel.unfollow() : viewModel.follow()
                }) {
                    Text(viewModel.user.isFollowed ?? false ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(viewModel.user.isFollowed ?? false ? Color.white : Color.blue)
                        .foregroundColor(viewModel.user.isFollowed ?? false ? .black : .white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewModel.user.isFollowed ?? false ? Color.gray : Color.clear, lineWidth: 1)
                        )
                }

                Button(action: {}) {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 16) // ✅ Add padding to the entire HStack
        }
    }
}
