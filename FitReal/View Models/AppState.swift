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
    
    var debug: Bool = false
    
    init(debug: Bool = false) {
        registerAuthStateHandler()
        
        if debug {
            appUser = AppState.loadSampleAppUserData(fireAuthID: "DEBUGID")
        }
    }
    
    var authStateHandle: AuthStateDidChangeListenerHandle?
    
    static func loadSampleAppUserData(fireAuthID: String) -> FRUser {
        let activityID = UUID().uuidString
        return FRUser(
            firstName: "John",
            lastName: "Appleseed",
            age: 17,
            fireAuthID: fireAuthID,
            friends: [],
            friendRequests: [],
            schedule: Schedule(
                monday: [],
                tuesday: [],
                wednesday: [],
                thursday: [],
                friday: [],
                saturday: [],
                sunday: ["7-9"]
            ),
            activities: [
                activityID: Activity(id: activityID, type: "Ride", stravaID: "NIL", caption: "Fun Run!", movingTime: 3456.0, elapsedTime: 3500.0, startDateLocal: Date.now, distance: 4000)
            ]
        )
    }
}
