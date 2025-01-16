//
//  EditProfileView.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2025-01-14.
//
//
//import SwiftUI
//import Kingfisher
//
//struct EditProfileView: View {
//    @Binding var user: User
//    @State private var selectedImage: UIImage?
//    @State private var profileImage: Image?
//    @State private var fullname: String = ""
//    @State private var bio: String = ""
//    @State private var showImagePicker = false
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        VStack {
//            // ✅ Profile Image Picker
//            if let profileImage = profileImage {
//                profileImage
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 120, height: 120)
//                    .clipShape(Circle())
//            } else {
//                KFImage(URL(string: user.profileImageUrl))
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 120, height: 120)
//                    .clipShape(Circle())
//            }
//
//            Button(action: { showImagePicker.toggle() }) {
//                Text("Change Profile Photo")
//                    .font(.system(size: 16, weight: .semibold))
//            }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: $selectedImage)
//            }
//
//            // ✅ Full Name Field
//            TextField("Full Name", text: $fullname)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            // ✅ Bio Field
//            TextField("Bio", text: $bio)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            // ✅ Save Button
//            Button(action: saveChanges) {
//                Text("Save Changes")
//                    .font(.system(size: 16, weight: .semibold))
//                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                    .padding(.top)
//            }
//
//            Spacer()
//        }
//        .padding()
//        .onAppear {
//            fullname = user.fullname
//            bio = user.bio ?? ""
//        }
//    }
//
//    // ✅ Load selected image
//    func saveChanges() {
//        // Update user data directly
//        user.fullname = fullname
//        user.bio = bio
//
//        // Handle image upload if a new image is selected
//        if let selectedImage = selectedImage {
//            ImageUploader.uploadImage(image: selectedImage, type: .profile) { imageUrl in
//                user.profileImageUrl = imageUrl
//                updateUserData()
//            }
//        } else {
//            updateUserData()
//        }
//
//        presentationMode.wrappedValue.dismiss()
//    }
//
//    // ✅ Save updated user data to Firestore
//    func updateUserData() {
//        guard let uid = user.id else { return }
//
//        let data: [String: Any] = [
//            "fullname": fullname,
//            "bio": bio,
//            "profileImageUrl": user.profileImageUrl
//        ]
//
//        COLLECTIONS_USERS.document(uid).updateData(data) { error in
//            if let error = error {
//                print("DEBUG: Failed to update user data \(error.localizedDescription)")
//                return
//            }
//            print("DEBUG: Successfully updated user data")
//        }
//    }
//}

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @Binding var user: User
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var fullname: String = ""
    @State private var bio: String = ""
    @State private var showImagePicker = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // ✅ Profile Image Picker
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            }

            Button(action: { showImagePicker.toggle() }) {
                Text("Change Profile Photo")
                    .font(.system(size: 16, weight: .semibold))
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $selectedImage)
            }

            // ✅ Full Name Field
            TextField("Full Name", text: $fullname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // ✅ Bio Field
            TextField("Bio", text: $bio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // ✅ Save Button
            Button(action: saveChanges) {
                Text("Save Changes")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            fullname = user.fullname
            bio = user.bio ?? ""
        }
    }

    // ✅ Load the selected image into the profileImage state
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }

    // ✅ Save changes to Firestore
    func saveChanges() {
        // Update user data directly
        user.fullname = fullname
        user.bio = bio

        // Handle image upload if a new image is selected
        if let selectedImage = selectedImage {
            ImageUploader.uploadImage(image: selectedImage, type: .profile) { imageUrl in
                user.profileImageUrl = imageUrl
                updateUserData()
            }
        } else {
            updateUserData()
        }

        presentationMode.wrappedValue.dismiss()
    }

    // ✅ Save updated user data to Firestore
    func updateUserData() {
        guard let uid = user.id else { return }

        let data: [String: Any] = [
            "fullname": fullname,
            "bio": bio,
            "profileImageUrl": user.profileImageUrl
        ]

        COLLECTIONS_USERS.document(uid).updateData(data) { error in
            if let error = error {
                print("DEBUG: Failed to update user data \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully updated user data")
        }
    }
}
