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
    @Published var appUser: FRUser? = nil
    
    @Published var authenticationState: AuthenticationStatus = .unauthenticated
    
    init() {
        registerAuthStateHandler()
        
        #warning("Sample FRUser is loaded here and should only be here for debug purposes.")
        appUser = FRUser(firstName: "John", lastName: "Appleseed", age: 17, fireAuthID: user?.uid ?? "Unknown ID", friendRequests: [], schedule: Schedule(monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: ["7-9"]), activities: [:])
    }
    
    var authStateHandle: AuthStateDidChangeListenerHandle?
}
