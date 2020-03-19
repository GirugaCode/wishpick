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
    
    // MARK: PROPERTIES
    let customAnimationPresentor = CustomAnimationPresentor()
    let customAnimationDismisser = CustomAnimationDismisser()
    
    // MARK: UI COMPONENTS
    /// Button to dismiss the camera controller
    let dismissCamera: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button to take a photo of Capture Session
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture-image").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Handles dismissing the view
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        setupCaptureSession()
        setupCameraUI()
    }

    // Hides the status bar when presenting Camera
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    /// Handles capturing a photo
    @objc func handleCapturePhoto() {
        print("Capture Photo")
        let settings = AVCapturePhotoSettings()
        
        // Sets up the preview format of the captured image
        guard let previewFormateType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormateType]
        
        // Captures the photos with settings and delegate functions
        output.capturePhoto(with: settings, delegate: self)
    }
    
    /**
     Sets up the capture session for the phones camera
     */
    let output = AVCapturePhotoOutput()
    fileprivate func setupCaptureSession() {
        // Inputs of camera's capture session
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Unable to access camera")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let err {
            print("Could not setup camera input:", err)
        }
        
        // Outputs of camera's capture session
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
    
    /**
     Uses the UIViewControllerTransitioningDelegate to animate the
     view transition for the camera to and from view.
     */
    private func presentAndDismissAnimation() {
        transitioningDelegate = self
        let customAnimationPresentor = CustomAnimationPresentor()
        let customAnimationDismisser = CustomAnimationDismisser()
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return customAnimationPresentor
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return customAnimationDismisser
        }
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    // Captures the photo in the camera view
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            print("Unable to get image data")
            return
        }
        // Sets up preview image view after image was taken
        let previewImage = UIImage(data: imageData)
        
        // Displays the container view of the taken photo
        let containerView = PreviewPhotoContainerView()
        containerView.previewImageView.image = previewImage
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CameraController: UIViewControllerTransitioningDelegate {
    // Delegates the present animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimationPresentor
    }
    // Delegates the dismiss animation
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customAnimationDismisser
    }
}
