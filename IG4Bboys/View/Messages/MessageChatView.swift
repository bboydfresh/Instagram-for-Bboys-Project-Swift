//
//  MessageChatView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct MessageChatView: View {
    
    @State var message = ""
    @ObservedObject var viewModel: MessagesViewModel
    @State var scrolled = false
    
    init(userId: String) {
        self.viewModel = MessagesViewModel(userId: userId)
    }
    
    var body: some View {
        VStack {
            
            ScrollViewReader { reader in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            MessageRowView(message: message)
                                .onAppear {
                                    if message.id == viewModel.messages.last?.id && !scrolled {
                                        reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                                        scrolled = true
                                    }
                                }
                        }
                        .onChange(of: viewModel.messages) { _ in
                            reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            MessageInputView(message: $message, action: sendMessage)
        }
    }
    
    func sendMessage() {
        viewModel.sendMessage(message: message)
        message = ""
        print("Message Sent")
    }
}
