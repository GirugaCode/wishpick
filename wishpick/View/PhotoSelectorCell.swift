//
//  PhotoSelectorCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 10/18/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    //MARK: UI COMPONENTS
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
