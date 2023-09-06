//
//  AuthenticateView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct AuthenticateView: View {
    enum AuthenticationMode {
        case signup, login
    }
    
    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @State private var errorMessage: String = ""
    
    @FocusState var emailIsFocused
    @FocusState var passwordIsFocused
    @FocusState var confirmPasswordIsFocused
    
    @State var mode: AuthenticationMode = .signup
    
    var title: String {
        mode == .signup ? "Sign Up": "Login"
    }
    
    var formIsValid: Bool {
        if mode == .signup {
            return !(onboardingVM.email.isEmpty || onboardingVM.password.isEmpty || onboardingVM.confirmPassword.isEmpty)
        } else {
            return !(onboardingVM.email.isEmpty || onboardingVM.password.isEmpty)
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text(title)
                    .font(.largeTitle.bold())
                Text("\(mode == .signup ? "Start": "Continue") your journey.")
                    .font(.headline)
            }
            .padding(.top, 50)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Enter your email here", text: $onboardingVM.email)
                        .focused($emailIsFocused)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 44)
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Enter your password here", text: $onboardingVM.password)
                        .focused($passwordIsFocused)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 44)
                }
                
                if mode == .signup {
                    VStack(alignment: .leading) {
                        Text("Confirm Password")
                        SecureField("Re-enter your password", text: $onboardingVM.confirmPassword)
                            .focused($confirmPasswordIsFocused)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .frame(minHeight: 44)
                    }
                }
            }
            
            Spacer()
            
            Text(errorMessage)
                .foregroundColor(.red)
                .frame(minHeight: 44)
                .multilineTextAlignment(.center)
                .padding()
            
            Button {
                if onboardingVM.password != onboardingVM.confirmPassword && mode == .signup {
                    errorMessage = "Password and Confirm Password fields do not match. Please try again."
                    return
                }
                
                Task {
                    var response: String? = nil
                    if mode == .signup {
                        response = await onboardingVM.signUpWithEmailPassword()
                    } else {
                        response = await onboardingVM.signInWithEmailPassword()
                    }
                    
                    if let response = response {
                        if response.starts(with: "Error") {
                            errorMessage = response[("Error: ".count)...]
                        } else {
                            errorMessage = ""
                        }
                    }
                }
            } label: {
                ZStack {
                    Text(onboardingVM.authenticationState == .authenticating ? "": title)
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
            
            Button("Or \(mode == .signup ? "Login": "Sign Up")") {
                withAnimation {
                    if mode == .signup {
                        mode = .login
                    } else {
                        mode = .signup
                    }
                    onboardingVM.password = ""
                    onboardingVM.confirmPassword = ""
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button("Done", action: dismiss)
                        .padding(.leading, UIScreen.main.bounds.width * 0.8)
                }
            }
        }
    }
    
    func dismiss() {
        emailIsFocused = false
        passwordIsFocused = false
        confirmPasswordIsFocused = false
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
            .preferredColorScheme(.dark)
    }
}
