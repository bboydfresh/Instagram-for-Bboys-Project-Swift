//
//  MessageRowView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Kingfisher

struct MessageRowView: View {
    
    let message: Message
    
    var ownAccount: Bool {
        return message.uid == AuthViewModel.shared.userSession?.uid
    }
    
    var body: some View {
        HStack(spacing: 15) {
            
            if !ownAccount {
                if let userImageURL = message.ownerImageURL {
                    KFImage(URL(string: userImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .clipShape(Circle())
                }
            }
            
            if ownAccount {
                Spacer(minLength: 0)
            }
            
            VStack(alignment: ownAccount ? .trailing : .leading , spacing: 5) {
                Text(message.message)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(MessageBubbleView(ownAccount: self.ownAccount))
                
                Text(message.timestampText ?? "")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(ownAccount ? .trailing : .leading, 10)
            }
            
            if !ownAccount {
                Spacer(minLength: 0)
            }
            
            if ownAccount {
                if let userImageURL = message.ownerImageURL {
                    KFImage(URL(string: userImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .clipShape(Circle())
                }
            }
            
        }.padding()
    }
}
