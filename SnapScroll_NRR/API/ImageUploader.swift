//
//  ImageUploader.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 11/10/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage


struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil){ _, error in
            
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            print("Successfully uploaded Image")
            
            ref.downloadURL() { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
