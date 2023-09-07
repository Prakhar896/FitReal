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
    @State var showingNewActivitySheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if let appUser = appState.appUser {
                    ScrollView {
                        ForEach(appUser.extractedActivities) { activity in
                            ActivityView(appUser: appUser, activityID: activity.id)
                        }
                    }
                    .padding()
                } else {
                    VStack {
                        ProgressView()
                    }
                    .onTapGesture {
                        Task {
                            guard let uid = appState.user?.uid else { return }
                            appState.appUser = await appState.backend.fetchUser(fireAuthID: uid)
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign Out") {
                        appState.signOut()
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Reset") {
                        UserDefaults.resetDefaults()
                    }
                    
                    Button("Configure") {
                        showingConfigureNextWorkoutSheet = true
                    }
                }
            }
            .onAppear {
                let showNewActivity = UserDefaults.standard.bool(forKey: "ShowNewActivityScreen")
                if showNewActivity || true {
                    showingNewActivitySheet = true
                }
                
//                if !appState.nextWorkoutActivated {
//                    print("Showing workout configuration view.")
//                    showingConfigureNextWorkoutSheet = true
//                }
            }
            .sheet(isPresented: $showingConfigureNextWorkoutSheet) {
                ConfigureNextWorkoutView(appState: appState)
            }
            .fullScreenCover(isPresented: $showingNewActivitySheet) {
                NewActivityView(appState: appState)
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
