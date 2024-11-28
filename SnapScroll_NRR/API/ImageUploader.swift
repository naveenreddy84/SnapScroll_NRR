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

//Enum for upload Type

enum UploadType {
    case profile
    case post
 //function to redirect to which path to ake based on profile and post
    
    var filePath: StorageReference{
        let filename = NSUUID().uuidString
        switch self{
        case .profile:
          return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        case .post:
           return Storage.storage().reference(withPath: "/post_images/\(filename)")
        }
    }
}

struct ImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        
        let ref = type.filePath
        
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
