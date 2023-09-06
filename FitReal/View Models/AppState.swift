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
    
    @Published var authenticationState: AuthenticationStatus = .unauthenticated
    
    var backend: BackendAPI
    
    var debug: Bool = false
    
    init(debug: Bool = false) {
        backend = BackendAPI()
        
        registerAuthStateHandler()
        if debug {
            appUser = AppState.loadSampleAppUserData(fireAuthID: "DEBUGID")
        }
        
        nextWorkoutActivated = UserDefaults.standard.bool(forKey: "NextWorkoutActivated")
    }
    
    var authStateHandle: AuthStateDidChangeListenerHandle?
    
    static func loadSampleAppUserData(fireAuthID: String) -> FRUser {
        let activityID = UUID().uuidString
        return FRUser(
            name: "John Appleseed",
            fireAuthID: fireAuthID,
            friends: [],
            friendRequests: [],
            nextWorkout: Date.now.addingTimeInterval(600),
            activities: [
                activityID: Activity(id: activityID, type: "Ride", stravaID: "NIL", caption: "Fun Run!", movingTime: 3456.0, elapsedTime: 3500.0, startDateLocal: Date.now, distance: 4000, frontImageURL: "https://i0.wp.com/techweez.com/wp-content/uploads/2022/03/vivo-lowlight-selfie-1-scaled.jpg?fit=2560%2C1920&ssl=1", rearImageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/A_water_taxi_at_Singapore_River.jpg/540px-A_water_taxi_at_Singapore_River.jpg", missed: false)
            ]
        )
    }
}
