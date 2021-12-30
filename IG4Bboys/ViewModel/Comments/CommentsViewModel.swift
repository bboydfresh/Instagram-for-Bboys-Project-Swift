//
//  CommentsViewModel.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase

class CommentsViewModel: ObservableObject {
    
    let post: Post
    
    @Published var comments = [Comment]()
    
    init(post: Post) {
        self.post = post
        fetchCommments()
    }

    func uploadComment(comment: String) {
        
        guard let postID = post.id else { return }
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        
        var data: [String: Any] = [ "comment" : comment,
                                    "uid" : userID,
                                    "timestamp" : Timestamp(date: Date()),
                                    "postOwnerId" : post.ownerUid,
                                    "username": user.username,
                                    "profileImageURL": user.profileImageURL]
        
        Firestore.firestore().collection("posts").document(postID).collection("post-comments").addDocument(data: data) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            NotificationsViewModel.sendNotification(withUid: self.post.ownerUid, type: .comment, post: self.post)
            
        }
        
    }
    
    func fetchCommments() {
        guard let postID = post.id else { return }
        
        Firestore.firestore().collection("posts").document(postID).collection("post-comments").addSnapshotListener { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            
            guard let documents = snap?.documentChanges.filter({ $0.type == .added}) else { return }
            print(documents.compactMap({ try? $0.document.data(as: Comment.self)}))
            self.comments.append(contentsOf: documents.compactMap({ try? $0.document.data(as: Comment.self)}))
            
        }
    }
    
}
