//
//  RootView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct RootView: View {
    @StateObject var appState: AppState = AppState()
    
    var body: some View {
        if appState.authenticationState == .authenticated {
            HomeView(appState: appState)
                .preferredColorScheme(.dark)
        } else {
            WelcomeView(appState: appState)
                .preferredColorScheme(.dark)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
    }
}
