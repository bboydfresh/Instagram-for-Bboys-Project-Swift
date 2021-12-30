//
//  PostGridView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    let config: PostGridConfig
    @ObservedObject var viewModel: GridViewModel
    
    init(config: PostGridConfig) {
        self.config = config
        self.viewModel = GridViewModel(config: config)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(viewModel.posts) { post in
                
                NavigationLink(destination: ScrollView{FeedCell(viewModel: FeedCellViewModel(post: post))}) {
                    KFImage(URL(string: post.imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                }
            }
        })
    }
}
