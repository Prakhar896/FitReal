//
//  OnboardingViewModel.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

@MainActor class AppState: ObservableObject {
    @Published var user: User? = nil
    
    @Published var authenticationState: AuthenticationStatus = .unauthenticated
    
    init() {
        registerAuthStateHandler()
    }
    
    var authStateHandle: AuthStateDidChangeListenerHandle?
}
