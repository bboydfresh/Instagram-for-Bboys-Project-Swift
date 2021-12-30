//
//  ProfileHeaderView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {

    @State var selectedImage: UIImage?
    @State var userImage: Image? = Image("profile-placeholder")
    @State var imagePickerRepresented = false
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {

                HStack {
                    
                    ZStack {
                        if let imageURL = viewModel.user.profileImageURL {
                            Button {
                                self.imagePickerRepresented.toggle()
                            } label: {
                                KFImage(URL(string: imageURL))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.leading, 16)
                            }.sheet(isPresented: $imagePickerRepresented, onDismiss: loadImage, content: {
                                ImagePicker(image: $selectedImage)
                            })

                        }
                        else {
                            Button {
                                self.imagePickerRepresented.toggle()
                            } label: {
                                userImage?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.leading, 16)
                            }.sheet(isPresented: $imagePickerRepresented, onDismiss: loadImage, content: {
                                ImagePicker(image: $selectedImage)
                            })

                        }
                    }
                    
                    
                    HStack(spacing: 16) {
                        UserStats(value: viewModel.user.stats?.posts ?? 0, title: "Posts")
                        UserStats(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                        UserStats(value: viewModel.user.stats?.following ?? 0, title: "Following")
                        
                    }
                    
                }
                
            
            
            Text(viewModel.user.fullname ?? "")
                .font(.system(size: 15, weight: .bold))
                .padding([.leading, .top])
                .padding(.leading, 8)
            
            if let bio = viewModel.user.bio{
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top, 1)
            }
            
            HStack {
                Spacer()
                ProfileButtonView(viewModel: viewModel)
                Spacer()
            }.padding(.top)
            
            
        }
    }
}

extension ProfileHeaderView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        userImage = Image(uiImage: selectedImage)
        viewModel.changeProfileImage(image: selectedImage) { (_) in
            print("DEBUG: Uploaded Image")
        }
    }
}
