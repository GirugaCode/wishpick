//
//  UserSearchCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/10/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    /// Profile Image for search results
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50 / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Username Label for search results
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont(name: Fonts.proximaAltBold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Seperator line between each cell
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserCell() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.8)
        ])
    }
}
