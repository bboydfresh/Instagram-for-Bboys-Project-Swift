//
//  EditProfileViewModel.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func saveBio(bio: String) {
        
        guard let userId = user.id else { return }
        
        Firestore.firestore().collection("users").document(userId).updateData(["bio": bio]) { err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.user.bio = bio
            self.uploadComplete = true
            
        }
        
    }
    
}
