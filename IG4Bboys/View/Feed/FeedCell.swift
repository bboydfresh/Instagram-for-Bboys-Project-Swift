//
//  FeedCell.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike: Bool {
        return viewModel.post.didLike ?? false
    }
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = viewModel.post.user {
                NavigationLink(destination: ProfileView(user: user)) {
                    HStack {
                        if let imageURL = viewModel.post.ownerImageURL{
                            KFImage(URL(string: imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .clipped()
                                .cornerRadius(18)
                        }
                        else {
                            Image("profile-placeholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .clipped()
                                .cornerRadius(18)
                        }
                        Text(viewModel.post.ownerUsername)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding([.leading, .bottom], 8)
                }
            }
            
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
            
            HStack(spacing: 16) {
                Button {
                    didLike ? viewModel.unlike() : viewModel.like()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? .red : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }

                
                if let post = viewModel.post {
                    NavigationLink(destination: CommentsView(post: post)) {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .padding(4)
                    }
                }
                

                Image(systemName: "paperplane")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
                    .font(.system(size: 20))
                    .padding(4)
                
            }
            .padding(.leading, 4)
            .foregroundColor(.black)
            
            Text(viewModel.likeText)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 0.5)
            
            HStack {
                Text(viewModel.post.ownerUsername).font(.system(size: 14, weight: .semibold)) + Text(" \(viewModel.post.caption)").font(.system(size: 14))
            }.padding(.horizontal, 8)
            
            Text(viewModel.timestamp)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
            
        }
    }
}

