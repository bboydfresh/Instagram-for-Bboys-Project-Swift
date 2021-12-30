//
//  FeedCellViewModel.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        fetchUser()
        checkLike()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(post.ownerUid).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.post.user = try? snap?.data(as: User.self)
            
            guard let userImageURL = self.post.user?.profileImageURL else { return }
            self.post.ownerImageURL = userImageURL
            
        }
    }
    
    
    
    func like() {
        
        guard let postUid = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("posts").document(postUid).collection("post-likes").document(userID).setData([:]) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(postUid).setData([:]) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("posts").document(postUid).updateData(["likes": self.post.likes + 1]) { (err) in
                    if let err = err {
                        print(err.localizedDescription)
                        return
                    }
                    
                    NotificationsViewModel.sendNotification(withUid: self.post.ownerUid, type: .like, post: self.post)
                    
                    self.post.likes += 1
                    self.post.didLike = true
                }
                
            }
            
        }
        
    }
    
    
    func checkLike() {
        
        guard let postId = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("posts").document(postId).collection("post-likes").document(userID).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let didLike = snap?.exists else { return }
            
            self.post.didLike = didLike
            
        }
    }
    
    
    func unlike() {
        
        guard post.likes > 0 else { return }
        guard let postUid = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("posts").document(postUid).collection("post-likes").document(userID).delete { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(postUid).delete { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                self.post.didLike = false
                self.post.likes -= 1
            }
            
        }
        
    }
    
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    
    var likeText: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    
}
