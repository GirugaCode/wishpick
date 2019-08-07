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
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: Fonts.proximaAltBold, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect with Facebook", for: .normal)
        button.titleEdgeInsets.left = 25
        button.imageEdgeInsets.right = 50
        button.setImage(#imageLiteral(resourceName: "facebook_icon"), for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.4745098039, blue: 0.7882352941, alpha: 1)
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(facebookSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
                let svc = MainTabViewController()
                svc.modalTransitionStyle = .crossDissolve
                self.present(svc, animated: true, completion: nil)
            })
        }
    }
    
    
    let emailLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up with E-mail", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        button.layer.cornerRadius = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(emailSignIn), for: .touchUpInside)
        return button
    }()
    
    @objc func emailSignIn() {
        let svc = EmailViewController()
        svc.modalTransitionStyle = .crossDissolve
        self.present(svc, animated: true, completion: nil)
    }
    
    let tosLabel: UILabel = {
        let label = UILabel()
        label.text = "By signing up, you agree to our Terms of Service and Privacy Policy."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.5019607843, green: 0.3647058824, blue: 0.1725490196, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6561305523, blue: 0.171354413, alpha: 1))
        
        setupLoginView()
        
        if (AccessToken.current != nil) {
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    fileprivate func setupLoginView() {
        
        // Stack View objects
        let topStackView = UIStackView(arrangedSubviews: [wishpickIcon, wishpickLabel, wishpickSubLabel])
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.distribution = .fillProportionally
        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.spacing = 10
        
        let bottomStackView = UIStackView(arrangedSubviews: [facebookLoginButton, emailLoginButton, tosLabel])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillProportionally
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .center
        bottomStackView.spacing = 20
        
        // Adding stack views to the view
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
}
