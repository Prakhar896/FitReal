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
    
    @ObservedObject var appState: AppState
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @FocusState var nameIsFocused
    @FocusState var emailIsFocused
    @FocusState var passwordIsFocused
    @FocusState var confirmPasswordIsFocused
    
    @State private var errorMessage: String = ""
    
    @State var mode: AuthenticationMode = .signup
    
    var title: String {
        mode == .signup ? "Sign Up": "Login"
    }
    
    var formIsValid: Bool {
        if mode == .signup {
            return !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        } else {
            return !(email.isEmpty || password.isEmpty)
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
                if mode == .signup {
                    VStack(alignment: .leading) {
                        Text("Name")
                        TextField("Enter your name", text: $name)
                            .focused($nameIsFocused)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .frame(minHeight: 44)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Enter your email here", text: $email)
                        .focused($emailIsFocused)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textContentType(.emailAddress)
                        .frame(minHeight: 44)
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Enter your password here", text: $password)
                        .focused($passwordIsFocused)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
//                        .textContentType(.password)
                        .frame(minHeight: 44)
                }
                
                if mode == .signup {
                    VStack(alignment: .leading) {
                        Text("Confirm Password")
                        SecureField("Re-enter your password", text: $confirmPassword)
                            .focused($confirmPasswordIsFocused)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
//                            .textContentType(.password)
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
                if password != confirmPassword && mode == .signup {
                    errorMessage = "Password and Confirm Password fields do not match. Please try again."
                    return
                }
                
                Task {
                    appState.authenticationState = .authenticating
                    
                    var success = false
                    if mode == .signup {
                        success = await createFireAuthUser()
                    } else {
                        success = await signInFireAuthUser()
                    }
                    
                    if success {
                        appState.appUser = AppState.loadSampleAppUserData(fireAuthID: appState.user?.uid ?? "DEBUGID", name: appState.user?.displayName ?? "John Appleseed")
                        appState.authenticationState = .authenticated
                    } else {
                        appState.authenticationState = .unauthenticated
                    }
                }
            } label: {
                ZStack {
                    Text(appState.authenticationState == .authenticating ? "": title)
                        .bold()
                        .foregroundColor(.black)
                    
                    if appState.authenticationState == .authenticating {
                        ProgressView()
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 44)
                .background(Color.accentColor)
                .cornerRadius(10)
            }
            .disabled(!formIsValid || appState.authenticationState == .authenticating)
            
            Button("Or \(mode == .signup ? "Login": "Sign Up")") {
                withAnimation {
                    if mode == .signup {
                        mode = .login
                    } else {
                        mode = .signup
                    }
                    password = ""
                    confirmPassword = ""
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
        nameIsFocused = false
        emailIsFocused = false
        passwordIsFocused = false
        confirmPasswordIsFocused = false
    }
    
    func createFireAuthUser() async -> Bool {
        var response: String? = nil
        response = await appState.signUp(withEmail: email, password: password)
        
        if let response = response {
            if response.starts(with: "Error") {
                errorMessage = response[("Error: ".count)...]
                return false
            } else {
                errorMessage = ""
                return true
            }
        } else {
            errorMessage = "An unknown error occurred in signing you up. Please try again."
            return false
        }
    }
    
    func signInFireAuthUser() async -> Bool {
        var response: String? = nil
        response = await appState.signIn(withEmail: email, password: password)
        
        if let response = response {
            if response.starts(with: "Error") {
                errorMessage = response[("Error: ".count)...]
                return false
            } else {
                errorMessage = ""
                return true
            }
        } else {
            errorMessage = "An unknown error occurred in signing you in. Please try again."
            return false
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView(appState: AppState())
            .preferredColorScheme(.dark)
    }
}
