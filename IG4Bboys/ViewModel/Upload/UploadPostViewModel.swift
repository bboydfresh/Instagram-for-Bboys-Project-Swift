//
//  UploadPostViewModel.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    func uploadPost(image: UIImage, caption: String) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            guard let uid = user.id else { return }
            
            let data = ["caption" : caption,
                        "timestamp" : Timestamp(date: Date()),
                        "likes": 0,
                        "imageURL" : imageURL,
                        "ownerUid" : uid,
                        "ownerUsername" : user.username ] as [String : Any]
            
            Firestore.firestore().collection("posts").addDocument(data: data) { err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
            }
        }
        
    }
    
}
