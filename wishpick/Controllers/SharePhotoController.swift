//
//  SharePhotoController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class SharePhotoController: UIViewController {
    
    //MARK: PROPERTIES
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    //MARK: UI COMPONENTS
    /// Container View to hold the image and text
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Image View to hold the selected photo
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Text View to hold the description of the image
    let descriptionView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Fonts.proximaRegular, size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: SETUP UI
    /**
     Sets up the User Interface for the SharePhotoController Controller
     
     The constraints and added subviews of the UI Componments,
     sets the delegates and other view UI related items
     */
    fileprivate func setupUI() {
        
        // Top Right Share Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 84),
            
            descriptionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            descriptionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
        ])
    }
    
    @objc func handleShare() {
        guard let image = selectedImage else { return }
        
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(filename)
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Failed to upload image", err)
                return
            }
            storageRef.downloadURL { (imageUrl, error) in
                if error != nil {
                    print("Failed to download URL:", error as Any)
                }
                print("Successfully uploaded image URL", imageUrl as Any)
                
                guard let imageUrlString = imageUrl?.absoluteString else { return }
                self.saveToDBwithURL(imageUrl: imageUrlString)
            }
        }
    }
    
    fileprivate func saveToDBwithURL(imageUrl: String) {
        guard let postImage = selectedImage else { return }
        guard let itemInfo = descriptionView.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageUrl": imageUrl, "itemInfo": itemInfo, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save post to DB", err)
                return
            }
            print("Successfully saved post to DB", ref)
        }
    }
    
    /// Hides the status bar on top of device
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
