//
//  HomePostCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    //MARK: PROPERTIES
    var post: Posts? {
        didSet {
            setPostImages()
        }
    }
    
    //MARK: UI COMPONENTS
    /// Image View for the large selected preview photos
    let photoImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     URL session to set the images to each cell in the profile
     */
    fileprivate func setPostImages() {
        guard let postImageUrl = post?.imageUrl else { return }
        photoImageView.loadImage(urlString: postImageUrl)
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
