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
    @State var imageTaken: Bool = false
    
    var body: some View {
        ZStack {
            if let appUser = appState.appUser {
                ZStack {
                    if !imageTaken {
                        CameraView(image: $receivedImage, taken: $imageTaken)
                            .edgesIgnoringSafeArea(.all)
                    } else {
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                    }
                    
                    VStack(alignment: .center) {
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
                        .background(.black)
                        .cornerRadius(10)
                        
                        
                        Spacer()
                    }
                }
                .onChange(of: receivedImage) { _ in
                    guard let receivedImage = receivedImage else { return }
                    image = Image(uiImage: receivedImage)
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
