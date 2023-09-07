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
    
    @State var startDate: Date = Date.now
    @State var endDate: Date = Date.now.addingTimeInterval(600)
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("\(appState.appUser?.name ?? "Hey"), \nwhen are you working out next?")
                    .multilineTextAlignment(.center)
                    .font(.title2.bold())
                    .padding()
                
                Text("Select the start date and time and the end date and time of your next workout. \n\nWe will notify you to post your FitReal anytime during your workout.")
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Spacer()
                
                VStack(spacing: 20) {
                    DatePicker("Start Datetime", selection: $startDate)
                    DatePicker("End Datetime", selection: $endDate)
                }
                
                Spacer()
                
                Button {
                    // add notification and update UserDefaults
                    let triggerDatetime = Date.randomBetween(start: startDate, end: endDate)
                    print(triggerDatetime.formatted())
                    
                    let notification = Notification.newPostNotification(triggerDatetime: triggerDatetime)
                    notification.add()
                    
                    UserDefaults.standard.set(true, forKey: "NextWorkoutActivated")
                    
                    dismiss()
                } label: {
                    Text("Confirm")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 44)
                        .foregroundColor(.black)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                
                Spacer()
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
