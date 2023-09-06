//
//  User.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation

struct FRUser: Codable {
    var firstName: String
    var lastName: String
    var age: Int
    var fireAuthID: String
    var friendRequests: [String]
    var schedule: Schedule
    var activities: [String: Activity]
}

struct Schedule: Codable {
    var monday: [String]
    var tuesday: [String]
    var wednesday: [String]
    var thursday: [String]
    var friday: [String]
    var saturday: [String]
    var sunday: [String]
}

struct Activity: Codable {
    var type: String
    var stravaID: String
    var caption: String
    var movingTime: Double
    var elapsedTime: Double
    var startDateLocal: Date
    var distance: Double
}
