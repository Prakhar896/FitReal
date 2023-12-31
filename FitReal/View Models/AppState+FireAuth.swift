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
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            
            // fetch user details from backend server
            
            print("User \(authResult.user.uid) signed in")
            return "Success"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    func signUp(withEmail email: String, password: String) async -> String {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            
            // create FRUser and submit to backend server
            
            print("User \(authResult.user.uid) signed in")
            return "Success"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            appUser = nil
            UserDefaults.standard.set(false, forKey: "NextWorkoutActivated")
            nextWorkoutActivated = false
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
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
