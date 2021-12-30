//
//  ProfileView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                
                ProfileHeaderView(viewModel: ProfileViewModel(user: user))
                
                if let currentProfileID = user.id {
                    
                    PostGridView(config: .profile(currentProfileID))
                }
            }
            .padding(.top)
        }
    }
}

