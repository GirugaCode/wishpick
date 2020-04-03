//
//  EmailLoginController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/23/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class EmailLoginController: UIViewController {
    
    //MARK: UI COMPONENTS
    /// Stackview to hold email, password, and login button
    lazy var loginFieldsStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// Email text field to input users email
    let emailTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.placeholder = "Email"
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
    
    /// Password text field to input users password
    let passwordTextField: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.placeholder = "Password"
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
    
    /// Login Button to authenticate users
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 18)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    /// Brings the user back to the Sign Up portion of the app
    let registerButton: UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 18) as Any])
        attributedText.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.proximaBold, size: 18) as Any]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: SELECTOR FUNCTIONS
    /**
     Switches the rootViewController back to sign up
     */
    @objc func handleShowSignUp() {
        AppDelegate.shared.rootViewController.switchToLoginWithEmail()
    }
    
    /**
    Enables the login button based on input in text fields
     */
    @objc func handleTextInput() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9679592252, green: 0.9208878279, blue: 0.8556233644, alpha: 1)
        }
    }
    
    /**
     Logs an exsisting user into the app with the correct credentials
     - Changes the rootViewController to the MainTabViewController
     - Displays Alert Error is user is nil
     */
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("Failed to sign in with email:", err)
            }
            
            if res?.user.uid != nil {
                // Resets the UI when logged in
                let mainTabBarController = MainTabViewController()
                mainTabBarController.setupViewControllers()
                
                UserDefaults.standard.setIsLoggedIn(value: true)
                
                AppDelegate.shared.rootViewController.switchToMainScreen()
        
            } else {
                let alert = UIAlertController(title: "Failed Attempt", message: "Invalid credentials, please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /**
     Sets up the UI for the sign in view controller
     */
    private func setupUI() {
        self.hideKeyboardWhenTappedAround()
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.5019607843, green: 0.3647058824, blue: 0.1725490196, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6561305523, blue: 0.171354413, alpha: 1))
        view.addSubview(loginFieldsStackview)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            loginFieldsStackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            loginFieldsStackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginFieldsStackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginFieldsStackview.heightAnchor.constraint(equalToConstant: 140),
            
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
