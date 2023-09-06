//
//  AuthenticateView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct AuthenticateView: View {
    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @State private var errorMessage: String = ""
    
    var formIsValid: Bool {
        return !(onboardingVM.email.isEmpty || onboardingVM.password.isEmpty || onboardingVM.confirmPassword.isEmpty)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Sign Up")
                    .font(.largeTitle.bold())
                Text("Start your journey.")
                    .font(.headline)
            }
            .padding(.top, 50)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Enter your email here", text: $onboardingVM.email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 44)
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Enter your password here", text: $onboardingVM.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 44)
                }
                
                VStack(alignment: .leading) {
                    Text("Confirm Password")
                    SecureField("Re-enter your password", text: $onboardingVM.confirmPassword)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 44)
                }
            }
            
            Spacer()
            
            Text(errorMessage)
                .foregroundColor(.red)
                .frame(minHeight: 44)
                .multilineTextAlignment(.center)
                .padding()
            
            Button {
                if onboardingVM.password != onboardingVM.confirmPassword {
                    errorMessage = "Password and Confirm Password fields do not match. Please try again."
                    return
                }
                
                Task {
                    let response = await onboardingVM.signUpWithEmailPassword()
                    if response.starts(with: "Error") {
                        errorMessage = response[("Error: ".count)...]
                    } else {
                        errorMessage = ""
                    }
                }
            } label: {
                ZStack {
                    Text(onboardingVM.authenticationState == .authenticating ? "": "Sign Up")
                        .bold()
                        .foregroundColor(.black)
                    
                    if onboardingVM.authenticationState == .authenticating {
                        ProgressView()
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 44)
                .background(Color.accentColor.opacity(onboardingVM.authenticationState == .authenticating ? 0.3: 1))
                .cornerRadius(10)
            }
            .disabled(!formIsValid)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
            .preferredColorScheme(.dark)
    }
}
