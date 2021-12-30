//
//  MessagesViewModel.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase

class MessagesViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    
    let currentUserID: String
    
    init(userId: String) {
        self.currentUserID = userId
        fetchMessages(withUid: currentUserID)
    }
    
    func fetchMessages(withUid currentProfileId: String) {
        
        guard let currentUserId = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("messages").document(currentUserId).collection("user-messages").document(currentProfileId).collection("messages").order(by: "timestamp", descending: false).addSnapshotListener { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let document = snap?.documentChanges.filter({ $0.type == .added}) else { return }
            self.messages.append(contentsOf: document.compactMap({ try? $0.document.data(as: Message.self)}))
            
        }
        
    }
    
    
    func sendMessage(message: String) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        guard let userId = AuthViewModel.shared.userSession?.uid else { return }
        
        guard let receiverId = user.id else { return }
        
        var data: [String: Any] = ["uid": userId,
                                   "receiverId" : currentUserID,
                                   "message" : message,
                                   "timestamp": Timestamp(date: Date()),
                                   "ownerImageURL" :user.profileImageURL]
        
        Firestore.firestore().collection("messages").document(userId).collection("user-messages").document(currentUserID).collection("messages").addDocument(data: data) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("messages").document(self.currentUserID).collection("user-messages").document(userId).collection("messages").addDocument(data: data) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
            }
        }
    }
    
    
}

