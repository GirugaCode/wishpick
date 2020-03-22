//
//  CommentCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/20/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    //MARK: PROPERTIES
    /// Displays all the comments in the Firebase DB related to post
    var comment: Comment? {
        didSet {
            setComment()
        }
    }
    //MARK: UI COMPONENTS
    /// Image view to show user profile in comments
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 40 / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Label to display comments
    let commentLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Fonts.proximaRegular, size: 14)
        textView.isScrollEnabled = false
        textView.backgroundColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommentUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Sets up the UI for the collection view of every comment
     */
    private func setupCommentUI() {
        backgroundColor = .yellow
        addSubview(profileImageView)
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    /**
    Retrieves all the comments to display and post for the current user
     - Attributed Text for custom user and comment layout
     - Load profile images of users who commented
     */
    private func setComment() {
        guard let comment = comment else { return }
        let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaExtraBold, size: 14) as Any])
        
        attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.proximaRegular, size: 14) as Any]))
        
        commentLabel.attributedText = attributedText
        profileImageView.loadImage(urlString: comment.user.profileImageUrl)
    }
}
