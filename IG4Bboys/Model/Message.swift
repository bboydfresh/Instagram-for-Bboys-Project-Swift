//
//  Message.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    let message: String
    let receiverId: String
    let ownerImageURL: String
    let timestamp: Timestamp
    let uid: String
    
    var timestampText: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
}

