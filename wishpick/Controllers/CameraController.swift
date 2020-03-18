//
//  CameraController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/11/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    
    // MARK: UI COMPONENTS
    
    /// Button to dismiss the camera controller
    let dismissCamera: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button to take a photo of Capture Session
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture-image"), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Handles capturing a photo
    @objc func handleCapturePhoto() {
        print("Capture Photo")
    }
    
    /// Handles dismissing the view
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupCameraUI()
    }
    
    /**
     Sets up the User Interface for the CameraController
     */
    private func setupCameraUI() {
        view.addSubview(dismissCamera)
        view.addSubview(capturePhotoButton)
        
        NSLayoutConstraint.activate([
            dismissCamera.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissCamera.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dismissCamera.widthAnchor.constraint(equalToConstant: 50),
            dismissCamera.heightAnchor.constraint(equalToConstant: 50),
            
            capturePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            capturePhotoButton.widthAnchor.constraint(equalToConstant: 80),
            capturePhotoButton.heightAnchor.constraint(equalToConstant: 80),
            capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    /**
     Sets up the capture session for the phones camera
     */
    fileprivate func setupCaptureSession() {
        // Inputs of camera's capture session
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let err {
            print("Could not setup camera input:", err)
        }
        
        // Outputs of camera's capture session
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)
        }
        
        // Setup the output preview, shows camera output
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        // Runs the camera session
        captureSession.startRunning()
        
    }
}
