//
//  HeaderView.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/29/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserProfileHeaderView: UICollectionViewCell {
    
    //MARK: UI COMPONENTS
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, usernameLabel, userBioDescription, userStatStackView])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sample-profile-image")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
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
        textView.text = "Hey there, I like things that make me stand out and makes be not hungry 😋 "
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: Fonts.proximaAltBold, size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        label.text = "9"
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
        label.text = "74"
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
        label.text = "890"
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
            
            userBioDescription.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
