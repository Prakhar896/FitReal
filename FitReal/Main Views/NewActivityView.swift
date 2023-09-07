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
    
    @State var image: Image? = nil
    @State var receivedImage: UIImage? = nil
    
    @State var showingImageCaptureSheet = false
    
    var header: some View {
        HStack(spacing: 15) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .bold()
                    .foregroundColor(.accentColor)
            }
            
            Text("New FitReal")
                .font(.title2.bold())
                .foregroundColor(.white)
            
        }
        .padding()
    }
    
    var canvas: some View {
        ZStack {
            Rectangle()
                .fill(.secondary.opacity(image == nil ? 1: 0.4))
            
            if image == nil {
                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            image?
                .resizable()
                .scaledToFit()
        }
        .onTapGesture {
            receivedImage = nil
            showingImageCaptureSheet = true
        }
        .cornerRadius(10)
    }
    
    var body: some View {
        VStack {
            if let appUser = appState.appUser {
                VStack {
                    VStack(alignment: .center) {
                        header
                        
                        canvas
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .padding(.top, 30)
                        
                        Button {
                           print("upload image to backend and refresh feed")
                        } label: {
                            Text("POST")
                                .foregroundColor(.accentColor)
                                .font(.title.weight(.heavy))
                        }
                        .padding(.vertical, 40)
                        .disabled(image == nil)
                        
                        Spacer()
                        Spacer()
                    }
                }
                .onAppear {
                    showingImageCaptureSheet = true
                }
                .onChange(of: receivedImage) { _ in
                    guard let receivedImage = receivedImage else { return }
                    image = Image(uiImage: receivedImage)
                }
                .fullScreenCover(isPresented: $showingImageCaptureSheet) {
                    CameraView(image: $receivedImage)
                }
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
