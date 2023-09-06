//
//  ContentView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

enum AuthenticationStatus {
    case unauthenticated, authenticating, authenticated
}

struct ContentView: View {
    @StateObject var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        NavigationView {
            if onboardingVM.authenticationState == .unauthenticated {
                VStack(spacing: 15) {
                    Spacer()
                    
                    TextField("Enter your email", text: $onboardingVM.email)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.emailAddress)
                    TextField("Password", text: $onboardingVM.password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)
                    
                    Spacer()
                    
                    Button("Sign Up") {
                        Task {
                            await onboardingVM.signUpWithEmailPassword()
                        }
                    }
                    .padding()
                    
                    Button("Sign In") {
                        Task {
                            await onboardingVM.signInWithEmailPassword()
                        }
                    }
                    .padding()
                }
                .padding()
                .navigationTitle("Authenticate")
            } else if onboardingVM.authenticationState == .authenticated {
                Text("\(onboardingVM.user?.email ?? "ERROR") is logged in!")
                    .padding()
                    .navigationTitle("Authenticated")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
