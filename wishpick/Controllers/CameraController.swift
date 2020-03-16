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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
    }
    
    fileprivate func setupCaptureSession() {
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
         
    }
}
