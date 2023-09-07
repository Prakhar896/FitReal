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
    @Published var nextWorkoutActivated = false
    @Published var images: [String: UIImage] = [:]
    
    @Published var authenticationState: AuthenticationStatus = .unauthenticated
    
    var backend: BackendAPI
    
    var debug: Bool = false
    
    init(debug: Bool = false) {
        backend = BackendAPI()
        
        registerAuthStateHandler()
        if debug {
            appUser = AppState.loadSampleAppUserData(fireAuthID: user?.uid ?? "DEBUGID", name: user?.displayName ?? "John Appleseed")
        }
        
        nextWorkoutActivated = UserDefaults.standard.bool(forKey: "NextWorkoutActivated")
    }
    
    var authStateHandle: AuthStateDidChangeListenerHandle?
    
    static func loadSampleAppUserData(fireAuthID: String, name: String) -> FRUser {
        let activityID = UUID().uuidString
        return FRUser(
            name: name,
            fireAuthID: fireAuthID,
            friends: [],
            friendRequests: [],
            nextWorkout: Date.now.addingTimeInterval(600),
            activities: [:]
        )
    }
}
