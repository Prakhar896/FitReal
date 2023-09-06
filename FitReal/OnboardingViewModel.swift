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
    
    func signInWithEmailPassword() async -> Bool {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func signUpWithEmailPassword() async -> Bool {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
