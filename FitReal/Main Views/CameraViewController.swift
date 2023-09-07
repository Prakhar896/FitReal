//
//  CameraViewController.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 7/9/23.
//

import UIKit
import SwiftUI
import AVFoundation
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    typealias UIViewControllerType = UIImagePickerController
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            guard let image = info[.originalImage] as? UIImage else { return }
            
            self.parent.image = image
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}





















//
//class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
//    private var permissionGranted = false // Flag for permission
//    private let captureSession = AVCaptureSession()
//    private let sessionQueue = DispatchQueue(label: "sessionQueue")
//    private var previewLayer = AVCaptureVideoPreviewLayer()
//    var screenRect: CGRect! = nil
//
//    // Detector
//    private var videoOutput = AVCaptureVideoDataOutput()
//    var requests = [VNRequest]()
//    var detectionLayer: CALayer! = nil
//
//
//    override func viewDidLoad() {
//        checkPermission()
//
//        sessionQueue.async { [unowned self] in
//            guard permissionGranted else { return }
//            self.setupCaptureSession()
//            self.captureSession.startRunning()
//        }
//    }
//
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        screenRect = UIScreen.main.bounds
//        self.previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
//
//        switch UIDevice.current.orientation {
//            // Home button on top
//        case UIDeviceOrientation.portraitUpsideDown:
//            self.previewLayer.connection?.videoOrientation = .portraitUpsideDown
//
//            // Home button on right
//        case UIDeviceOrientation.landscapeLeft:
//            self.previewLayer.connection?.videoOrientation = .landscapeRight
//
//            // Home button on left
//        case UIDeviceOrientation.landscapeRight:
//            self.previewLayer.connection?.videoOrientation = .landscapeLeft
//
//            // Home button at bottom
//        case UIDeviceOrientation.portrait:
//            self.previewLayer.connection?.videoOrientation = .portrait
//
//        default:
//            break
//        }
//    }
//
//    func checkPermission() {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//            // Permission has been granted before
//        case .authorized:
//            permissionGranted = true
//
//            // Permission has not been requested yet
//        case .notDetermined:
//            requestPermission()
//
//        default:
//            permissionGranted = false
//        }
//    }
//
//    func requestPermission() {
//        sessionQueue.suspend()
//        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
//            self.permissionGranted = granted
//            self.sessionQueue.resume()
//        }
//    }
//
//    func setupCaptureSession() {
//        // Camera input
//        guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera,for: .video, position: .back) else { return }
//        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
//
//        guard captureSession.canAddInput(videoDeviceInput) else { return }
//        captureSession.addInput(videoDeviceInput)
//
//        // Preview layer
//        screenRect = UIScreen.main.bounds
//
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
//        previewLayer.connection?.videoOrientation = .portrait
//
//        videoOutput.connection(with: .video)?.videoOrientation = .portrait
//
//        // Updates to UI must be on main queue
//        DispatchQueue.main.async { [weak self] in
//            self!.view.layer.addSublayer(self!.previewLayer)
//        }
//    }
//}
//
//struct CameraViewController: UIViewControllerRepresentable {
//
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        return ViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//    }
//}
