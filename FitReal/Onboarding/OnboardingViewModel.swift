//
//  OnboardingViewModel.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation
import FirebaseAuth

@MainActor class OnboardingViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: User? = nil
    
    @Published var authenticationState: AuthenticationStatus = .unauthenticated
    
    init() {
        registerAuthStateHandler()
    }
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    func registerAuthStateHandler() {
        if authStateHandle == nil {
            authStateHandle = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated: .authenticated
            })
        }
    }
    
    func signInWithEmailPassword() async -> String {
        do {
            authenticationState = .authenticating
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return "Success"
        } catch {
            authenticationState = .unauthenticated
            return "Error: \(error.localizedDescription)"
        }
    }
    
    func signUpWithEmailPassword() async -> String {
        do {
            authenticationState = .authenticating
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return "Success"
        } catch {
            authenticationState = .unauthenticated
            return "Error: \(error.localizedDescription)"
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() async -> String {
        do {
            try await user?.delete()
            authenticationState = .unauthenticated
            return "Success"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
}
