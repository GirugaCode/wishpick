//
//  ViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class EmailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: UI COMPONENTS
    let createAccLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.font = UIFont(name: Fonts.proximaThin, size: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailStackView, usernameStackView, passwordStackView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        
        return textField
    }()
    
    lazy var usernameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        
        return textField
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 8
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)

        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 18)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add-photo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 28)
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
    
    let exisitingAccLabel: UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 18) as Any])
        attributedText.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.proximaBold, size: 18) as Any]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 18)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(backTransition), for: .touchUpInside)

        return button
    }()
    
    //MARK: SEGUES
    @objc func backTransition() {
        AppDelegate.shared.rootViewController.switchToLogin()
    }
    
    //MARK: TEXT VALIDATIONS
    @objc func handleTextInput() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        }
    }
    
    //MARK: AUTH
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            // Check to see if user is created
            if let err = error {
                print("Failed to create user:", err)
                return
            }
            // Sign the user in if no error occured
            if error == nil {
                Auth.auth().signIn(withEmail: email,
                                   password: password)
                
                print("Sucessfully created user:", Auth.auth().currentUser?.uid ?? "")
            }
            
            guard let image = self.addPhotoButton.imageView?.image else { return }
            
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)

            storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Failed to upload profile picture:", err)
                    return
                }
                
                storageRef.downloadURL { (imageUrl, error) in
                    if let error = error {
                        print("Failed to download URL", error)
                    }
                    
                    guard let profileImageUrl = imageUrl?.absoluteString else { return }
                    print("Sucessfully uploaded image to DB", profileImageUrl)
                    
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    let dictionaryValues = ["username":username, "profileImageUrl": profileImageUrl, "blockedUsers": []] as [String : Any]
                    let values = [userID:dictionaryValues]

                     Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                         if let err = err {
                             print("Failed to save user info:", err)
                             return
                         }

                         print("Successfully saved user info!", userID)
                         // Analytics to track sign up
                         Analytics.logEvent(AnalyticsEventSignUp, parameters: [:])
                     })
                }
                
            }
        }
        UserDefaults.standard.setIsLoggedIn(value: true)
        AppDelegate.shared.rootViewController.switchToUserOnBoarding()
    }
    
    @objc func handleShowSignIn() {
        AppDelegate.shared.rootViewController.switchToSignInWithEmail()
    }
    
    //MARK: OVERRIDE FUNCTIONS
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func loadView() {
        super.loadView()
        setupInputFieldsView()
    }
    
    //MARK: UI SETUP
    fileprivate func setupInputFieldsView() {

        // Adding Views
        view.addSubview(createAccLabel)
        view.addSubview(mainStackView)
        view.addSubview(signupButton)
        view.addSubview(exisitingAccLabel)
        view.addSubview(addPhotoButton)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            // Back button
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            backButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            // Top Label
            createAccLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 15),
            createAccLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2.5),
            createAccLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
            createAccLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Text Field Stacks
            mainStackView.topAnchor.constraint(equalTo: createAccLabel.bottomAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mainStackView.heightAnchor.constraint(equalToConstant: 290),
            
            // Sign up Button
            signupButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Add Photo Button
            addPhotoButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 10),
            addPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            addPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 120),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 30),
            
            // Existing Account Label
            exisitingAccLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exisitingAccLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exisitingAccLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exisitingAccLabel.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    fileprivate func setupUI() {
        // Set up background gradient
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.5019607843, green: 0.3647058824, blue: 0.1725490196, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6561305523, blue: 0.171354413, alpha: 1))
        self.hideKeyboardWhenTappedAround()
    }
    
    /// Picker Controller function to allow user to choose and set image as profile
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            addPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            addPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        addPhotoButton.layer.cornerRadius = 30/2
        addPhotoButton.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
}

