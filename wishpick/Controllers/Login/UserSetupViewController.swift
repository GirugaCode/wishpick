//
//  UserSetupViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 8/28/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserSetupViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to wishpick"
        label.font = UIFont(name: Fonts.proximaRegular, size: 28)
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

        label.text =
        """
        wishpick wants to provide
        a real way for people to connect and know which
        items they want to make that next occasion special
        """
        
        let colorRange = "wishpick"
        let range = (label.text! as NSString).range(of: colorRange)
        let attribute = NSMutableAttributedString.init(string: label.text!)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.magenta, range: range)
        label.attributedText = attribute
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 30)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    //MARK: Load Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setButtonCornerRadius()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        continueButton.roundedButton(button: continueButton)
        
        // Stack View objects
        let mainStackView = UIStackView(arrangedSubviews: [welcomeLabel, userSetupAsset, descriptionLabel, continueButton])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .fill
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 10
        
        // Adding stack views to the view
        view.addSubview(mainStackView)
        
        // Constraining the UI
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    fileprivate func setButtonCornerRadius() {
        continueButton.roundedButton(button: continueButton)
    }
}
