//
//  ProfileButtonView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct ProfileButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var editProfileShow = false
    
    var didFollow: Bool {
        return viewModel.user.didFollow ?? false
    }
    
    var body: some View {
        
        if viewModel.user.isCurrentUser {
            Button {
                self.editProfileShow.toggle()
            } label: {
                
                Text("Edit Profile")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 360, height: 36)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
            }.sheet(isPresented: $editProfileShow, content: {
                EditProfileView(user: $viewModel.user)
            })

        }
        else {
            HStack(spacing: 16) {
                Button {
                    didFollow ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    
                    Text(didFollow ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(didFollow ? .black : .white)
                        .background(didFollow ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: didFollow ? 1 : 0)
                        )
                }.cornerRadius(3)
                
                if let userId = viewModel.user.id {
                    NavigationLink(destination: MessageChatView(userId: userId)) {
                        Text("Message")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 172, height: 32)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }


            }
        }
        
        
    }
}
