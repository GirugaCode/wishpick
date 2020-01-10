//
//  UserSetupPg2VC.swift
//  wishpick
//
//  Created by Ryan Nguyen on 10/17/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class UserSetupPg2VC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: UI COMPONENTS
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userAddImage, buildProfileLabel, descriptionLabel, promptLabel, addPhotoButton, skipButton])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let userAddImage: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add-profile-pic"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buildProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's build your profile"
        label.font = UIFont(name: Fonts.proximaAltBold, size: 28)
        label.textColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()

        label.text = "wishpick is a platform for you to share all the possible items you wish you had but rather have someone gift you."
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
    
    let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Lets start by uploading a profile picture"
        label.numberOfLines = 0
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add a Photo", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 28)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            userAddImage.setImage(editedImage, for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            userAddImage.setImage(originalImage, for: .normal)
        }
        
        userAddImage.layer.cornerRadius = userAddImage.frame.width/2
        userAddImage.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 28)
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
        addPhotoButton.roundedButton(button: addPhotoButton)
        
        // Constraining the UI
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 300),
            addPhotoButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.085),
            addPhotoButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            userAddImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            userAddImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.34),
            ])
    }
    
    fileprivate func setButtonCornerRadius() {
        addPhotoButton.roundedButton(button: addPhotoButton)
    }
}
