//
//  User.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation

struct FRUser {
    var firstName: String
    var lastName: String
    var age: Int
    var fireAuthID: String
    var friendRequests: [String]
    var schedule: Schedule
    var activities: [String: Activity]
}

struct Schedule {
    var monday: [String]
    var tuesday: [String]
    var wednesday: [String]
    var thursday: [String]
    var friday: [String]
    var saturday: [String]
    var sunday: [String]
}

struct Activity {
    var type: String
    var stravaID: String
    var caption: String
    var movingTime: Double
    var elapsedTime: Double
    var startDateLocal: Date
    var distance: Double
}
