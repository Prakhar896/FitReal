//
//  ActivityView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var appState: AppState
    var appUser: FRUser
    var activityID: String
    
    var activity: Activity? {
        appUser.extractedActivities.first { $0.id == activityID }
    }
    
    @State var reversed = false
    
    var frontImageName: String {
        reversed ? "RearSample": "FrontSample"
    }
    
    var rearImageName: String {
        reversed ? "FrontSample": "RearSample"
    }
    
    var activityImage: UIImage {
        appState.images[activityID] ?? UIImage(systemName: "photo.fill")!
    }
    
    var body: some View {
        if let activity = activity {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 40))
                    
                    VStack(alignment: .leading) {
                        Text("\(appUser.name)")
                            .bold()
                            .font(.headline)
                        Text(activity.startDateLocal.formatted())
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                // Image Canvas
                ZStack {
                    Image(uiImage: activityImage)
                        .resizable()
                        .clipped()
                }
                .cornerRadius(10)
                
                Text(activity.caption)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: 500)
        } else {
            Text("Failed to fetch activity.")
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static let sampleUser = AppState.loadSampleAppUserData(fireAuthID: "DEBUGID")
    static let sampleActivityID = sampleUser.extractedActivities.first!.id
    
    static var previews: some View {
        ActivityView(appState: AppState(debug: true), appUser: sampleUser, activityID: sampleActivityID)
            .preferredColorScheme(.dark)
    }
}
