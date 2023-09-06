//
//  ContentView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showingIntro: Bool = false
    @State private var introOpacity = 0.0
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Image("FitRealLogo")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .cornerRadius(10)
                .shadow(radius: 10)
            
            Text("FitReal")
                .font(.system(size: 40))
                .fontWeight(.black)
                .font(.largeTitle)
                .padding()
            
            if showingIntro {
                VStack {
                    Text("Revolutionising the norm of sharing about fitness.")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Enter your workout routine and FitReal will send you a notification anytime during a workout to take a picture and share it with your friends!")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("So, what are you waiting for?")
                        .padding()
                        .padding(.top, 40)
                        .bold()
                }
                .opacity(introOpacity)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            withAnimation(.spring(blendDuration: 1.5).delay(2)) {
                introOpacity = 1
                showingIntro = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .preferredColorScheme(.dark)
    }
}
