//
//  ViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let createAccLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account"
        label.font = UIFont.systemFont(ofSize: 35.0)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9758192897, green: 0.5812135339, blue: 0.02668368816, alpha: 1)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupInputFields()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8957236409, blue: 0.7335234284, alpha: 1)
    }
    
    fileprivate func setupInputFields() {
        
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
        
        view.addSubview(createAccLabel)
        view.addSubview(stackView)
        view.addSubview(signupButton)

        NSLayoutConstraint.activate([
            createAccLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 17),
            createAccLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3.5),
            createAccLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
            createAccLabel.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: createAccLabel.bottomAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stackView.heightAnchor.constraint(equalToConstant: 290),
            
            signupButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}

