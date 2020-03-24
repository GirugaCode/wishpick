//
//  PreviewPhotoContainerView.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/17/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Photos
import UIKit

class PreviewPhotoContainerView: UIView {
    
    //MARK: UI COMPONENTS
    /// Image view for the taken photo
    let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Button to dismiss the taken photo
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button to save photo in device
    let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "save-image").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: SELECTOR FUNCTIONS
    /// Dismisses the view controller
    @objc func handleCancel(){
        super.removeFromSuperview()
    }
    
    /// Saves the image to device
    @objc func handleSave(){
        guard let previewImage = previewImageView.image else { return }
        let library = PHPhotoLibrary.shared() // Access to photo library in device
        // Requests the preview image to be stored
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
        }) { (success, err) in
            if let err = err {
                print("Failed to save image to photo library:", err)
            }
            print("Successfully added to photo library")
            
            DispatchQueue.main.async {
                self.showSavedPhotoFeedback()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPreviewImageUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: DISPLAY UI
    /**
    Sets up the User Interface for the CameraController Container View
    */
    private func setupPreviewImageUI() {
        addSubview(previewImageView)
        addSubview(cancelButton)
        addSubview(saveButton)
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor),
            previewImageView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor),
            previewImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            previewImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    /**
     Displays feedback for user when photo is sucessfully saved to devices
     */
    private func showSavedPhotoFeedback() {
        let savedLabel = UILabel()
        savedLabel.text = "Saved Successfully"
        savedLabel.font = UIFont(name: Fonts.proximaRegular, size: 12)
        savedLabel.textAlignment = .center
        savedLabel.textColor = .white
        savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        savedLabel.numberOfLines = 0
        savedLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
        savedLabel.center = self.center
        
        self.addSubview(savedLabel)
        
        savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
            
        }) { (completed) in
            // Completed
            UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                savedLabel.alpha = 0
                
            }) { (_) in
                savedLabel.removeFromSuperview()
            }
        }
    }
}
