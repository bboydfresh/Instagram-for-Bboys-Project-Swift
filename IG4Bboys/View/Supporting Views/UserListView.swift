//
//  UserListView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filterUsers(withText: searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    
                    NavigationLink(destination: LazyView(ProfileView(user: user))) {
                        UserCell(user: user)
                            .padding(.leading, 8)
                    }
                }
            }
        }
    }
}


