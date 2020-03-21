//
//  CommentsController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/18/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class CommentsController: UICollectionViewController {
    
    //MARK: PROPERTIES
    var post: Posts?
    var comments = [Comment]()
    let cellId = "cellId"
    
    //MARK: UI COMPONENTS
    /// Container View for writing in comments
    lazy var containerView: UIView = {
        /// Outer container view for comments
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    /// Text Field to write in comments
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// Submit button the send comments
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaAltBold, size: 14)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /**
     Creates comments child in Firebase DB, passes in
     - commentTextField.text
     - creationDate
     - uid
     as values
     */
    @objc func handleSubmit() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let postId = self.post?.id ?? ""
        let values = ["text": commentTextField.text ?? "",
                      "creationDate": Date().timeIntervalSince1970,
                      "uid": uid] as [String : Any]
        
        Database.database()
            .reference()
            .child("comments")
            .child(postId)
            .childByAutoId()
            .updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to insert comment:", err)
                return
            }
            print("Sucessfully inserted comment")
        }
    }
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchComments()
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
    
    /**
     Setsup the collection view of all the comments
     */
    private func setupCollectionView() {
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .red
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0) // Fixes the extra space for comment cells
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    /**
     Fetches all the comments in the Firebase DB
     - Adds each comment in DB to comments array property
     - Reloads the view
     */
    fileprivate func fetchComments() {
        guard let postId = self.post?.id else { return }
        let ref = Database.database()
            .reference()
            .child("comments")
            .child(postId)
        
        ref.observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let comment = Comment(dictionary: dictionary)
            
            self.comments.append(comment)
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to observe comments")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentCell
        cell.comment = self.comments[indexPath.item]
        return cell
    }
}

extension CommentsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
