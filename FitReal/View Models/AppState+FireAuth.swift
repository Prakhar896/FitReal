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
                
                // temporarily, load sample data
                if user != nil {
                    self.appUser = AppState.loadSampleAppUserData(fireAuthID: user?.uid ?? "No Fire Auth ID")
                }
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
            
            // fetch user details from backend server
            
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
            
            // create FRUser and submit to backend server
            
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
            appUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() async -> String {
        do {
            try await user?.delete()
            authenticationState = .unauthenticated
            appUser = nil
            return "Success"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
}
