//
//  LoginViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 8/7/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import UIKit

class LoginViewController: UIViewController {
    
    //MARK: UI COMPONENTS
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wishpickIcon, wishpickLabel, wishpickSubLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let wishpickIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wishpick_icon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let wishpickLabel: UILabel = {
        let label = UILabel()
        label.text = "wishpick"
        label.textColor = #colorLiteral(red: 0.4039215686, green: 0.3215686275, blue: 0.3215686275, alpha: 1)
        label.font = UIFont(name: Fonts.proximaAltBold, size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wishpickSubLabel: UILabel = {
        let label = UILabel()
        label.text = "want & share"
        label.textColor = #colorLiteral(red: 1, green: 0.9387172013, blue: 0.6734803082, alpha: 1)
        label.font = UIFont(name: Fonts.proximaAltBold, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [facebookLoginButton, emailLoginButton, tosLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect with Facebook", for: .normal)
        button.titleEdgeInsets.left = 25
        button.imageEdgeInsets.right = 50
        button.setImage(#imageLiteral(resourceName: "facebook_icon"), for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.4745098039, blue: 0.7882352941, alpha: 1)
        button.addTarget(self, action: #selector(facebookSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up with E-mail", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        button.layer.cornerRadius = 40
        button.titleEdgeInsets.left = 10
        button.imageEdgeInsets.right = 20
        button.setImage(#imageLiteral(resourceName: "Email-Icon"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(emailSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tosLabel: UILabel = {
        let label = UILabel()
        label.text = "By signing up, you agree to our Terms of Service and Privacy Policy."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: AUTH
    @objc func facebookSignIn() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                if (AccessToken.current != nil) {
                    AppDelegate.shared.rootViewController.switchToUserSetup()
                    Analytics.logEvent(AnalyticsEventLogin, parameters: [
                        "Login Error": error ?? "Error",
                        "Username": user ?? "User"
                    ])
                }
                
            })
        }
    }
    
    @objc func emailSignIn() {
        AppDelegate.shared.rootViewController.switchToLoginWithEmail()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setButtonCornerRadius()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginView()
    }
  
    //MARK: UI SETUP
    fileprivate func setupLoginView() {
        
        // Set up background gradient
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.5019607843, green: 0.3647058824, blue: 0.1725490196, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6561305523, blue: 0.171354413, alpha: 1))
        
        // Adding Views
        view.addSubview(topStackView)
        view.addSubview(bottomStackView)
        
        // Constraining the UI
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 15),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            bottomStackView.topAnchor.constraint(equalToSystemSpacingBelow: topStackView.bottomAnchor, multiplier: 30),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            
            
            // Size of Facebook Login Button
            facebookLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            facebookLoginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            // Size of Email Login Button
            emailLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            emailLoginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
            
            ])
    }
    
    fileprivate func setButtonCornerRadius() {
        facebookLoginButton.roundedButton(button: facebookLoginButton)
        emailLoginButton.roundedButton(button: emailLoginButton)
    }
}
