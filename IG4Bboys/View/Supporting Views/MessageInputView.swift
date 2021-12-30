//
//  MessageInputView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct MessageInputView: View {
    
    @Binding var message: String
    
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            TextField("Message...", text: $message)
                .padding(.horizontal)
                .frame(height: 45)
                .background(Color.primary.opacity(0.06))
                .clipShape(Capsule())
            
            if !message.isEmpty {
                Button(action: action) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }.padding()
    }
}


