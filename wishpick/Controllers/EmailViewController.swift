//
//  ViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class EmailViewController: UIViewController {
    
    
    let createAccLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account"
        label.font = UIFont(name: Fonts.proximaThin, size: 38)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        
        return textField
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Username"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: Fonts.proximaRegular, size: 18)
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 8
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowRadius = 2
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 18)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 18)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        button.addTarget(self, action: #selector(backTransition), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Back Transition
    @objc func backTransition() {
        AppDelegate.shared.rootViewController.showLoginScreen()
    }
    
    //MARK: Text Validation
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
    
    //MARK: Auth
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
            
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let usernameValues = ["username":username]
            let values = [userID:usernameValues]
            
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err {
                    print("Failed to save user info:", err)
                    return
                }
                
                print("Successfully saved user info!", userID)
            })
        }
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFieldsView()
    }
    
    //MARK: UI setup
    fileprivate func setupInputFieldsView() {
        
        // Set up background gradient
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.5019607843, green: 0.3647058824, blue: 0.1725490196, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6561305523, blue: 0.171354413, alpha: 1))
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        emailStackView.distribution = .fillEqually
        emailStackView.axis = .vertical
        emailStackView.spacing = 2
        
        let usernameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        usernameStackView.translatesAutoresizingMaskIntoConstraints = false
        usernameStackView.distribution = .fillEqually
        usernameStackView.axis = .vertical
        usernameStackView.spacing = 2
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.distribution = .fillEqually
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 2
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView, usernameStackView, passwordStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let buttonStackView = UIStackView(arrangedSubviews: [signupButton, backButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        
        view.addSubview(createAccLabel)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            createAccLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 15),
            createAccLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2.5),
            createAccLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
            createAccLabel.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: createAccLabel.bottomAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stackView.heightAnchor.constraint(equalToConstant: 290),
            
            buttonStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}

