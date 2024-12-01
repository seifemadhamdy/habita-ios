//
//  AuthenticationView.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import SwiftUI
import Firebase

struct AuthenticationView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Habita")
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: (UIScreen.main.bounds.width * 0.5))
                    .foregroundColor(.primary)
                    .padding(.top, 16)
                
                Text("Authenticate into \nHabita")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .padding(.top, 16)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(.primary.opacity(0.1))
                    .cornerRadius(12.5)
                    .padding(.top, 32)
                    .onChange(of: email) { newValue in
                        authenticationViewModel.setEmail(newValue)
                    }
                    .onReceive(authenticationViewModel.$email) { updatedEmail in
                        if updatedEmail != email {
                            email = updatedEmail
                        }
                    }
                
                if !authenticationViewModel.validateEmail() {
                    Text("Valid email format")
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding()
                    .background(.primary.opacity(0.1))
                    .cornerRadius(12.5)
                    .padding(.top, 16)
                    .onChange(of: password) { newValue in
                        authenticationViewModel.setPassword(newValue)
                    }
                    .onReceive(authenticationViewModel.$password) { updatedPassword in
                        if updatedPassword != password {
                            password = updatedPassword
                        }
                    }
                
                if !authenticationViewModel.validatePassword() {
                    Text("At least 8 characters, with an uppercase letter, a digit, a special character, and no spaces.")
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Spacer()
                
                Button(action: {
                    authenticationViewModel.continueWithEmailAndPassword()
                }) {
                    Text("Continue")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("ContainerColor"))
                        .cornerRadius(25)
                        .foregroundColor(.primary)
                        .padding(.top, 32)
                }
                
                Text("Clicking 'Continue' will sign you into your existing account or create a new one with the provided credentials.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .padding(.top, 16)
            }
            .padding(16)
            .alert(isPresented: Binding(
                get: { authenticationViewModel.errorMessage != nil },
                set: { _ in authenticationViewModel.errorMessage = nil }
            )) {
                Alert(
                    title: Text("An error occured"),
                    message: Text(authenticationViewModel.errorMessage ?? "An unknown error occurred"),
                    dismissButton: .cancel(Text("Close"))
                )
            }
            .onAppear {
                isLoggedIn = authenticationViewModel.firebaseUser != nil
            }
            .onReceive(authenticationViewModel.$firebaseUser) { firebaseUser in
                if firebaseUser != nil {
                    isLoggedIn = true
                }
            }.navigationDestination(isPresented: $isLoggedIn) {
                HomeView().navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
