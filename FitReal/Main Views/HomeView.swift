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
    
    @State var showingConfigureNextWorkoutSheet = false
    
    var appUser: FRUser? {
        appState.appUser
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if let appUser = appUser {
                    ScrollView {
                        ForEach(appUser.extractedActivities) { activity in
                            ActivityView(appUser: appUser, activityID: activity.id)
                        }
                    }
                    .padding()
                    .navigationTitle("Home")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Sign Out") {
                                appState.signOut()
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                if !appState.nextWorkoutActivated {
                    showingConfigureNextWorkoutSheet = true
                }
            }
            .sheet(isPresented: $showingConfigureNextWorkoutSheet) {
                Text("Configure your next workout....")
            }
            .task {
                guard let uid = appState.user?.uid else { return }
                appState.appUser = await appState.backend.fetchUser(fireAuthID: uid)
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
