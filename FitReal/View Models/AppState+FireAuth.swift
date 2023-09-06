//
//  FireAuth.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation
import FirebaseAuth
import SwiftUI

extension AppState {
    func registerAuthStateHandler() {
        if authStateHandle == nil {
            authStateHandle = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated: .authenticated
            })
        }
    }
    
    func signIn(withEmail email: String, password: String) async -> String {
        do {
            withAnimation {
                authenticationState = .authenticating
            }
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
    
    func signUp(withEmail email: String, password: String) async -> String {
        do {
            withAnimation {
                authenticationState = .authenticating
            }
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
            withAnimation {
                authenticationState = .unauthenticated
            }
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