//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Kotya on 31/03/2025.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var email = ""
    @Published var password = ""
    
    private let authService = AuthService()
    
    init() {
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            }
            catch {
                print("[AuthViewModel] Cannot sign in: \(error)")
            }
        }
    }
}
