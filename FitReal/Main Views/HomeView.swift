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
            }
            .onAppear {
                if !appState.nextWorkoutActivated {
                    showingConfigureNextWorkoutSheet = true
                }
            }
            .sheet(isPresented: $showingConfigureNextWorkoutSheet) {
                ConfigureNextWorkoutView(appState: appState)
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
