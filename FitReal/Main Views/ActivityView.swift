//
//  ActivityView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct ActivityView: View {
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
                    Image(rearImageName)
                        .resizable()
                        .clipped()
                    
                    VStack {
                        HStack {
                            Image(frontImageName)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 100, maxHeight: 130)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 3)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        reversed.toggle()
                                    }
                                }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding([.top, .leading])
                }
                .cornerRadius(10)
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
        ActivityView(appUser: sampleUser, activityID: sampleActivityID)
            .preferredColorScheme(.dark)
    }
}
