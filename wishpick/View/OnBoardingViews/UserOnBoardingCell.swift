//
//  UserOnBoardingCell.swift
//  wishpick
//
//  Created by Ryan Nguyen on 4/28/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserOnBoardingCell: UICollectionViewCell {
    
    // MARK: PROPERTIES
    /// View Model for the user onboarding cells
    var UserOnBoardingCellViewModel: UserOnBoardingCellViewModel? {
        didSet {
            setOnBoardingCell()
        }
    }
    
    /// Public String Identifier for the reusable cell
    static var identifier: String = "cellId"
    
    // MARK: UI COMPONENTS
    /// Top Container to hold Image View
    let topImageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Image view for on-boarding
    private let onboardingImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "wishpick_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// Description text for on-boarding
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "What is this?", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 40)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)])
        attributedText.append(NSAttributedString(string: "\n\nNot sure what to wear today? Let us help you out! Fashion Flick is here to help you decide and inspire what to wear for the day so you do not have to struggle thinking of an outfit.", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 21)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2117647059, green: 0.1529411765, blue: 0.1725490196, alpha: 1)]))
        
        textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    /// Set up contraints for on-boarding cell
    private func setupLayout() {
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(onboardingImageView)
            
        addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.47),
            
            onboardingImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            onboardingImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            onboardingImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.9),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
            ])
    }
    
    private func setOnBoardingCell() {
        guard let unwrappedPage = UserOnBoardingCellViewModel else { return }
        onboardingImageView.image = unwrappedPage.imageName
        
        let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 35)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)])
        
        attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 20)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2117647059, green: 0.1529411765, blue: 0.1725490196, alpha: 1)]))
        
        descriptionTextView.attributedText = attributedText
        descriptionTextView.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
