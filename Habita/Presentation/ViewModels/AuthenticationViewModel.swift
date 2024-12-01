//
//  AuthenticationViewModel.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import SwiftUI
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    private let firebaseAuth = Auth.auth()
    
    @Published var firebaseUser: User? = Auth.auth().currentUser
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    
    private let validateEmailUseCase = ValidateEmailUseCase()
    private let validatePasswordUseCase = ValidatePasswordUseCase()
    
    func getEmail() -> String {
        return email
    }
    
    func setEmail(_ value: String) {
        email = value
    }
    
    func getPassword() -> String {
        return password
    }
    
    func setPassword(_ value: String) {
        password = value
    }
    
    func validateEmail() -> Bool {
        return !email.isEmpty && validateEmailUseCase.execute(email: email)
    }
    
    func validatePassword() -> Bool {
        return !password.isEmpty && validatePasswordUseCase.execute(password: password)
    }
    
    func continueWithEmailAndPassword() {
        guard validateEmail() && validatePassword() else {
            errorMessage = "Invalid email or password"
            return
        }
        
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let user = result?.user {
                self?.firebaseUser = user
            } else {
                self?.handleAuthenticationError(error)
            }
        }
    }
    
    private func getErrorMessageFromException(_ error: Error?) -> String {
        return error?.localizedDescription ?? "Unknown error"
    }
    
    private func createUser() {
        firebaseAuth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let user = result?.user {
                self?.firebaseUser = user
            } else {
                self?.errorMessage = self?.getErrorMessageFromException(error)
            }
        }
    }
    
    private func handleAuthenticationError(_ error: Error?) {
        if let authError = error as? AuthErrorCode, authError.code == .wrongPassword {
            createUser()
        } else {
            errorMessage = getErrorMessageFromException(error)
        }
    }
}
