//
//  LoginSignupView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI

struct LoginSignupView: View {
    @ObservedObject var viewModel: LoginSignupViewModel
    var body: some View {
        VStack(spacing: 15){
           
            textContent
            
            emailTextField
            passTextField
            
            actionButton
            
            Spacer()
        }
        .padding()
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginSignupView(viewModel: LoginSignupViewModel(mode: .login, isPushed: .constant(true)))
        }
    }
}

extension LoginSignupView{
    
    private var textContent: some View{
        VStack(spacing: 10) {
            Text(viewModel.title)
                .font(.largeTitle).bold()
            Text(viewModel.subtitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, 25)
    }
    
    private var emailTextField: some View{
        TextField("Email", text: $viewModel.email)
            .modifier(TextFieldCustomRoundedStyle())
            .textInputAutocapitalization(.never)
    }
    
    private var passTextField: some View{
        SecureField("Password", text: $viewModel.password)
            .modifier(TextFieldCustomRoundedStyle())
            .textInputAutocapitalization(.never)
    }
    
    private var actionButton: some View{
        Button {
            viewModel.tappedActionButton()
        } label: {
            Text(viewModel.buttonTitle)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.primary)
                .hCenter()
                
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(viewModel.isValid)
    }
}
