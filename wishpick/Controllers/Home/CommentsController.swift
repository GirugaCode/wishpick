//
//  CommentsController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/18/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class CommentsController: UICollectionViewController {
    
    //MARK: UI COMPONENTS
    /// Container View for writing in comments
    var containerView: UIView = {
        /// Outer container view for comments
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        /// Text Field to write in comments
        let commentTextField = UITextField()
        commentTextField.placeholder = "Enter Comment"
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        /// Submit button the send comments
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        submitButton.titleLabel?.font = UIFont(name: Fonts.proximaAltBold, size: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(commentTextField)
        containerView.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            commentTextField.topAnchor.constraint(equalTo: containerView.topAnchor),
            commentTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            commentTextField.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            submitButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            submitButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            submitButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        return containerView
    }()
        
    @objc func handleSubmit() {
        print("Handles Submitting a comment")
    }
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .red
        navigationItem.title = "Comments"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    /// View to allow typed in information
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    /// Calls inputAccessoryView to allow users to interact with page
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
