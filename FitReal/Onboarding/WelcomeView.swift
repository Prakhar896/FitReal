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
    
    var debug = false
    
    var body: some View {
        NavigationView {
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
                        Text("Revolutionising the norm of sharing your fitness lifestyle.")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Text("Enter your workout routine and FitReal will send you a notification anytime during a workout to take a picture and share it with your friends!")
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Text("So, what are you waiting for?")
                            .padding()
                            .padding(.top, 20)
                            .bold()
                        
                        NavigationLink {
                            AuthenticateView()
                        } label: {
                            Text("Get Started")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 44)
                                .background(Color.accentColor)
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    .opacity(introOpacity)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                if debug {
                    introOpacity = 1
                    showingIntro = true
                } else {
                    withAnimation(.spring(blendDuration: 1.5).delay(2)) {
                        introOpacity = 1
                        showingIntro = true
                    }
                }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(debug: true)
            .preferredColorScheme(.dark)
    }
}
