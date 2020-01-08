//
//  UserProfilePhotoCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    //MARK: PROPERTIES
    var post: Posts? {
        didSet {
            setPostImages()
        }
    }
    
    //MARK: UI COMPONENTS
    /// Image View for the users posted images
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     URL session to set the images to each cell in the profile
     */
    fileprivate func setPostImages() {
        guard let imageUrl = post?.imageUrl else { return }
        
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to post image", err)
            }
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.photoImageView.image = photoImage
            }
        }.resume()
    }
    
    //MARK: SETUP UI
    /**
     Sets up the User Interface for the UserProfilePhotoCell
     
     The constraints and added subviews of the UI Componments,
     sets the view UI related items
     */
    fileprivate func setupCells() {
        addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
