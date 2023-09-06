//
//  HomeView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @ObservedObject var appState: AppState
    
    var appUser: FRUser? {
        appState.appUser
    }
    
    var body: some View {
        NavigationView {
            if let appUser = appUser {
                ScrollView {
                    ForEach(appUser.extractedActivities) { activity in
                        VStack(alignment: .center) {
                            Text("\(activity.type)")
                            Text("\(activity.caption)")
                            Text("\(activity.distance)m")
                        }
                    }
                }
                .navigationTitle("Home")
            } else {
                Text("Error")
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appState: AppState(debug: true))
            .preferredColorScheme(.dark)
    }
}
