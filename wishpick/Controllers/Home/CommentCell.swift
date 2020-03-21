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
            commentLabel.text = comment?.text
        }
    }
    
    /// Label to display comments
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.proximaRegular, size: 14)
        label.numberOfLines = 0
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
