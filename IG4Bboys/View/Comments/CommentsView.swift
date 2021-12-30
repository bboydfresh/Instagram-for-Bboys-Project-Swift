//
//  CommentsView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct CommentsView: View {
    
    @State var comment = ""
    @ObservedObject var viewModel: CommentsViewModel
    
    init(post: Post) {
        self.viewModel = CommentsViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments){ comment in
                        CommentsCellView(comment: comment)
                    }
                }
            }
            CommentInputView(inputText: $comment, action: uploadComment)
        }
    }
    
    func uploadComment() {
        viewModel.uploadComment(comment: comment)
        self.comment = ""
    }
}

