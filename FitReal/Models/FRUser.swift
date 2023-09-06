//
//  User.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import Foundation

struct FRUser: Codable {
    var name: String
    var fireAuthID: String
    var friends: [String]
    var friendRequests: [String]
    var nextWorkout: Date
    var activities: [String: Activity]
    
    var extractedActivities: [Activity] {
        var returnValue: [Activity] = []
        for (_, activity) in activities {
            returnValue.append(activity)
        }
        return returnValue
    }
}

struct Activity: Codable, Identifiable {
    var id: String
    var type: String
    var stravaID: String
    var caption: String
    var movingTime: Double
    var elapsedTime: Double
    var startDateLocal: Date
    var distance: Double
    var frontImageURL: String
    var rearImageURL: String
    var missed: Bool
}
