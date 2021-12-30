//
//  EditProfileView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var bio : String
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bio = State(initialValue: _user.bio.wrappedValue ?? "")
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    viewModel.saveBio(bio: bio)
                }, label: {
                    Text("Done")
                })
                
            }.padding()
            
            TextArea(text: $bio, placeholder: "Add your bio...")
                .frame(width: 370, height: 200)
                .padding()
            
            Spacer()
        }
        .onReceive(viewModel.$uploadComplete) { complete in
            if complete {
                self.mode.wrappedValue.dismiss()
                self.user.bio = viewModel.user.bio
            }
        }
    }
}
