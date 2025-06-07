//
//  RegisterView.swift
//  Evrollment
//
//  Created by Saputra on 07/06/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var viewModel = AuthViewModel()
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .disabled(viewModel.isLoading)
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .disabled(viewModel.isLoading)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            Button(action: {
                Task {
                    await viewModel.register(email: email, password: password)
                }
            }) {
                Text("Register")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(email.isEmpty || password.isEmpty || viewModel.isLoading)
            
            if let success = viewModel.successMessage {
                Text(success)
                    .foregroundStyle(.green)
                    .multilineTextAlignment(.center)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
