//
//  ForgotPasswordView.swift
//  IG4Bboys
//
//  Created by Donald Dang on 2021-12-29.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Binding var email: String
    
    init(email: Binding<String>) {
        self._email = email
    }
    
    var body: some View {
        NavigationView {
            VStack {
                    Image("instagram-text-logo")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .foregroundColor(.black)
                
                VStack(spacing: -16) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .padding(.horizontal, 32)

                }
                
                HStack {
                    Spacer()

                    NavigationLink(
                        destination: SignInView().navigationBarHidden(true),
                        label: {
                            Text("Go Back")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding(.top)
                            .padding(.trailing, 28)
                        })
                    
                }.padding(.horizontal, 24)
                            
                Button(action: {
                    
                }, label: {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                    
                })
                
                Spacer()
                
                NavigationLink(
                    destination: SignInView().navigationBarHidden(true),
                    label: {
                        HStack {
                            Text("Already have an account?")
                                .font(.system(size: 14, weight: .semibold))
                            
                            Text("Sign In")
                                .font(.system(size: 14))
                        }
                    })
                
            }.padding(.top, -100)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(email: .constant("email"))
    }
}
