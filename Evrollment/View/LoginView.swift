//
//  LoginPage.swift
//  Evrollment
//
//  Created by Saputra on 09/06/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var viewModel = AuthViewModel()
    @State private var navigateToRoleDashboard = false
    @State private var userRole: String?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
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
                        await viewModel.login(email: email, password: password)
                        if let role = viewModel.user?.role {
                            userRole = role
                            navigateToRoleDashboard = true
                        }
                    }
                }) {
                    Text("Login")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(email.isEmpty || password.isEmpty || viewModel.isLoading)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }
                
                NavigationLink(destination: RegisterView()) {
                    Text("Don't have an account? Register here.")
                        .font(.footnote)
                        .foregroundStyle(.blue)
                }
                Spacer()
            }
            
            .padding()
            .navigationDestination(isPresented: $navigateToRoleDashboard) {
                if userRole == "USER" {
                    UserDashboard()
                } else if userRole == "ADMIN" {
                    AdminDashboard()
                } else {
                    Text("Unknown Role")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
