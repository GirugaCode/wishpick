//
//  HomePostCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

/**
 Custom Delegate method to delegate which comment section
 is selected.
 */
protocol HomePostCellDelegate {
    func didTapComment(post: Posts)
    func didLike(for cell: HomePostCell)
}

class HomePostCell: UICollectionViewCell {
    
    //MARK: PROPERTIES
    /// Instance of the Custom Delegate
    var delegate: HomePostCellDelegate?
    
    /// Receives all the post images from the user
    var post: Posts? {
        didSet {
            setPostImages()
            setProfileInfo()
            setupAttributedText()
            setPostLikes()
        }
    }
    
    //MARK: UI COMPONENTS
    /// Image View for the user profile image
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40 / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont(name: Fonts.proximaAltLight, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Image View for the main posted photos
    let photoImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Like button for each post
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart-unfilled").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Comment button for each post
    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Share button for each post
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share-button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Description Label to give details to each post
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Notifies the Comment Controller which post the app is
     pushing into
     */
    @objc func handleComment() {
        print("Showing comment section")
        guard let post = post else { return }
        delegate?.didTapComment(post: post)
    }
    
    /**
     Notifies the HomeController to handle
     the liking of a post
     */
    @objc func handleLike() {
        delegate?.didLike(for: self)
    }
    
    //MARK: SETUP UI
    /**
     Sets up the User Interface for the UserProfilePhotoCell
     
     The constraints and added subviews of the UI Componments,
     sets the view UI related items
     */
    fileprivate func setupCells() {
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(photoImageView)
        addSubview(descriptionLabel)
        
        setupPostActionButtons()
        
        NSLayoutConstraint.activate([
            userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userProfileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 40),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            usernameLabel.topAnchor.constraint(equalTo: topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: photoImageView.topAnchor),
            
            photoImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            
            descriptionLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
    }
    
    /**
     Sets up the Action item buttons on the bottom of each post
     
     The constraints and added subviews of the UI Componments,
     sets the view UI related items
     */
    fileprivate func setupPostActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(shareButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.widthAnchor.constraint(equalToConstant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            shareButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    /**
     URL session to set the images to each cell in the profile
     */
    fileprivate func setPostImages() {
        guard let postImageUrl = post?.imageUrl else { return }
        photoImageView.loadImage(urlString: postImageUrl)
    }
    
    /**
     URL session to set the images to each cell in the profile
     */
    fileprivate func setProfileInfo() {
        // Sets up the username for each post
        usernameLabel.text = post?.user.username
        // Adds the profile image to each post
        guard let profileImageUrl = post?.user.profileImageUrl else { return }
        userProfileImageView.loadImage(urlString: profileImageUrl)
    }
    
    /**
     Sets up the information text for each post with the attributed strings
     */
    fileprivate func setupAttributedText() {
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaBold, size: 14) as Any])
        attributedText.append(NSAttributedString(string: " \(post.itemInfo)", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 12) as Any]))
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 14) as Any]))
        
        let timeAgoDisplay = post.creationDate.timeAgo() // Uses date extension to display time ago
        attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaAltThin, size: 12) as Any]))
        
        descriptionLabel.attributedText = attributedText
    }
    
    /**
     Sets up the like feature by checking the FireBase value
     in HomeController
     */
    fileprivate func setPostLikes() {
        likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "heart-filled").withRenderingMode(.alwaysOriginal): #imageLiteral(resourceName: "heart-unfilled").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
}
