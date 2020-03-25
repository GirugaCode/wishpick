//
//  HeaderView.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/29/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class UserProfileHeaderView: UICollectionViewCell {
    
    //MARK: PROPERTIES
    var user: User? {
        didSet {
            setupProfile()
            setupEditFollowButton()
        }
    }
    
    //MARK: UI COMPONENTS
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, usernameLabel, userBioDescription, editProfileFollowButton, userStatStackView])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let profileImageView: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 80/2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ryan N."
        label.font = UIFont(name: Fonts.proximaExtraBold, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userBioDescription: UITextView = {
        let textView = UITextView()
        textView.text = "Hey there, I like things that make me stand out and makes me not hungry 😋 "
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: Fonts.proximaAltBold, size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    /// Profile Button to either Follow/Unfollow or Edit Profile
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.4039215686, green: 0.3215686275, blue: 0.3215686275, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 14)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.8980392157, blue: 0.7529411765, alpha: 1)
        button.addTarget(self, action: #selector(handleEditProfileOrFollow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var userStatStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wantsStackView, followersStackView, followingStackView])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 80
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var wantsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wantsNumber, wantsLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let wantsNumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: Fonts.proximaRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wantsLabel: UILabel = {
        let label = UILabel()
        label.text = "wants"
        label.font = UIFont(name: Fonts.proximaRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followersNumber, followersLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let followersNumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: Fonts.proximaRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers"
        label.font = UIFont(name: Fonts.proximaRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingNumber, followingLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let followingNumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: Fonts.proximaRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.font = UIFont(name: Fonts.proximaRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        setupProfileHeader()        
    }
    
    private func setupProfileHeader() {
        addSubview(profileStackView)
        
        NSLayoutConstraint.activate([
            profileStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            userBioDescription.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            editProfileFollowButton.widthAnchor.constraint(equalToConstant: 150),
            editProfileFollowButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     URL session to set up the profile
     */
    fileprivate func setupProfile() {
        // Transfered the user profile image
        guard let profileImageUrl = user?.profileImageUrl else { return }
        profileImageView.loadImage(urlString: profileImageUrl)
        
        // Transfered the username label
        usernameLabel.text = user?.username
    }
    
    /**
     Checks if the current user is following or not following a user when searched
     
     Updates the UI of the profile button based on current user and searched user
     */
    fileprivate func setupEditFollowButton() {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        if currentUser == userId {
            // edit profile
        } else {
            // Check if user is following
            Database.database().reference().child("following").child(currentUser).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                    self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
                    
                } else {
                    self.setupFollowStyle()
                }
                
            }) { (err) in
                print("Failed to check if following:", err)
            }
        }
    }
    
    /**
     Handles the follow and unfollow feature and updates Firebase Database
     */
    @objc func handleEditProfileOrFollow() {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        // Unfollow Logic
        if editProfileFollowButton.titleLabel?.text == "Unfollow" {
            Database.database().reference().child("following").child(currentUser).child(userId).removeValue { (err, ref) in
                if let err = err {
                    print("Failed to unfollow user:", err)
                    return
                }
                print("Sucessfully unfollowed user:", self.user?.username ?? "")
                self.setupFollowStyle()
            }
        }
            // Follow Logic
        else {
            let ref = Database.database().reference().child("following").child(currentUser)
            let values = [userId: 1]
            ref.updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("Failed to follow user:", err)
                    return
                }
                print("Succesfully followed user: ", self.user?.username ?? "")
                self.setupUnfollowStyle()
            }
        }
    }
    
    /**
     Style changes for setting up the follow style button
     */
    fileprivate func setupFollowStyle() {
        self.editProfileFollowButton.setTitle("Follow", for: .normal)
        self.editProfileFollowButton.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.7254901961, blue: 0.3411764706, alpha: 1)
        self.editProfileFollowButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.editProfileFollowButton.titleLabel?.font = UIFont(name: Fonts.proximaAltBold, size: 14)
    }
    /**
     Style changes for setting up the unfollow style button
     */
    fileprivate func setupUnfollowStyle() {
        self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
        self.editProfileFollowButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.editProfileFollowButton.setTitleColor(#colorLiteral(red: 0.4039215686, green: 0.3215686275, blue: 0.3215686275, alpha: 1), for: .normal)
        self.editProfileFollowButton.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 14)
    }
    
}
