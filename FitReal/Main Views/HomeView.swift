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
    
    var body: some View {
        NavigationView {
            ScrollView {
                Button("Sign Out", action: appState.signOut)
            }
            .navigationTitle("Home")
        }
        .preferredColorScheme(.dark)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appState: AppState())
            .preferredColorScheme(.dark)
    }
}
