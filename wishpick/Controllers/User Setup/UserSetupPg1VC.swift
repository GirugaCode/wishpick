//
//  UserSetupViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 8/28/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserSetupPg1VC: UIViewController {
    
    // MARK: UI COMPONENTS
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, userSetupAsset, descriptionLabel, continueButton])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 70
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to wishpick"
        label.font = UIFont(name: Fonts.proximaAltBold, size: 28)
        label.textColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userSetupAsset: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user-setup-1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()

        label.text = "wishpick wants to provide a real way for people to connect and know which items they want to make that next occasion special!"
        label.numberOfLines = 0
        label.font = UIFont(name: Fonts.proximaRegular, size: 20)
        label.textAlignment = .center
        let colorRange = "wishpick"
        let range = (label.text! as NSString).range(of: colorRange)
        let attribute = NSMutableAttributedString.init(string: label.text!)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1), range: range)
        label.attributedText = attribute
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 28)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
        button.addTarget(self, action: #selector(tempPush), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func tempPush() {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    //MARK: OVERRIDE FUNCTIONS
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setButtonCornerRadius()
        self.navigationController?.navigationBar.isHidden = true;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    //MARK: SETUP UI
    fileprivate func setupUI() {
        // Adding stack views to the view
        view.addSubview(mainStackView)
        
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        continueButton.roundedButton(button: continueButton)
        
        // Constraining the UI
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 300),
            continueButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.085),
            continueButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            ])
    }
    
    fileprivate func setButtonCornerRadius() {
        continueButton.roundedButton(button: continueButton)
    }
}
