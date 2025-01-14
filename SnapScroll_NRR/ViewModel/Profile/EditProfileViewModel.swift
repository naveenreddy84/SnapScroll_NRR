//
//  EditProfileViewModel.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2025-01-14.
import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var showImagePicker = false

    init(user: User) {
        self.user = user
    }

    func updateProfile(fullname: String, bio: String, image: UIImage?) {
        guard let uid = user.id else { return }

        var data: [String: Any] = [
            "fullname": fullname,
            "bio": bio
        ]

        if let image = image {
            ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
                data["profileImageUrl"] = imageUrl
                COLLECTIONS_USERS.document(uid).updateData(data)
            }
        } else {
            COLLECTIONS_USERS.document(uid).updateData(data)
        }
    }
}
