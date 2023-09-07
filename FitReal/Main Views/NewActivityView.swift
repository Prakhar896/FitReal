//
//  NewActivityView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 7/9/23.
//

import SwiftUI

struct NewActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var appState: AppState
    
    var body: some View {
        ZStack {
            if let appUser = appState.appUser {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.down")
                                .bold()
                                .foregroundColor(.accentColor)
                        }
                        
                        Text("New FitReal")
                            .font(.title2.bold())
                            .padding()
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding([.horizontal], 15)
            } else {
                VStack {
                    Text("An error occurred. Please try again.")
                    Button("Dismiss") {
                        dismiss()
                    }
                    .padding()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct NewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityView(appState: AppState(debug: true))
    }
}
