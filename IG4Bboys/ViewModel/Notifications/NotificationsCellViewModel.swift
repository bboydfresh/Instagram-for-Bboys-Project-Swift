//
//  NotificationsCellViewModel.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase

class NotificationsCellViewModel: ObservableObject {
    
    @Published var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
        fetchUser()
        fetchPost()
        checkFollow()
    }
    
    var timestamp: String {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
        
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(notification.uid).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.notification.user = try? snap?.data(as: User.self)
            
        }
    }
    
    func fetchPost() {
        
        guard let postID = notification.postId else { return }
        
        Firestore.firestore().collection("posts").document(postID).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.notification.post = try? snap?.data(as: Post.self)
            
        }
    }
    
    func follow() {
        
        UserService.follow(uid: notification.uid) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            NotificationsViewModel.sendNotification(withUid: self.notification.uid, type: .follow)
            self.notification.didFollow = true
        }
    }
    
    func unfollow() {
        
        UserService.unfollow(uid: notification.uid) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.notification.didFollow = false
        }
    }
    
    func checkFollow() {
        
        guard notification.type == .follow else { return }
        
        UserService.checkFollow(userId: notification.uid) { didFollow in
            self.notification.didFollow = didFollow
        }
    }
    
}
