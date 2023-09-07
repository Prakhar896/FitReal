//
//  ConfigureNextWorkoutView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 7/9/23.
//

import SwiftUI

struct ConfigureNextWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(appState.appUser?.name ?? "Hey"), \nwhen are you working out next?")
                    .multilineTextAlignment(.center)
                    .font(.title2.bold())
            }
            .padding()
            .navigationTitle("Next Workout")
        }
        .preferredColorScheme(.dark)
    }
}

struct ConfigureNextWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureNextWorkoutView(appState: AppState(debug: true))
    }
}
