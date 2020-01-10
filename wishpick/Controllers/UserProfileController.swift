//
//  UserProfileController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/29/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

class UserProfileController: UICollectionViewController {
    
    //MARK: PROPERTIES
    var posts = [Posts]()
    var user: User?
    let cellId = "cellId"
    
    //MARK: UI COMPONENTS
    /// Logout button in the user profile screen
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.titleEdgeInsets.left = 25
        button.imageEdgeInsets.right = 50
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.4745098039, blue: 0.7882352941, alpha: 1)
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleLogout() {
        //TODO: Make root vc on main feed
        LoginManager().logOut()
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        fetchOrderedPosts()
        setupUI()
    }
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
    }
    
    //MARK: FIREBASE FETCHING
    fileprivate func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return } // Current User
        
        // Gives the username value and stop constantly observing the node in DB
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let usernameDict = snapshot.value as? [String:Any] else { return }
            let username = usernameDict["username"] as? String
            
            self.navigationItem.title = username
            
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
    fileprivate func fetchPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return } // Current User
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            // Iterates through the Dictionary of posts and appends it to the post array
            dictionaries.forEach { (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                                
                let post = Posts(dictionary: dictionary)
                self.posts.append(post)
            }
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch photos", err)
        }
    }
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return } // Current User
        
        let ref = Database.database().reference().child("posts").child(uid)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let post = Posts(dictionary: dictionary)
            self.posts.insert(post, at: 0) // Inserts the post in reverse order
            
            self.collectionView?.reloadData()
        }) { (err) in
            print("Failed to fetch ordered photos", err)
        }
    }
    
    //MARK: SETUP UI
    fileprivate func setupUI() {
        let logout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9960784314, green: 0.7254901961, blue: 0.3411764706, alpha: 1)
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = logout
    }
    
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Creates a flow layout for the collectionview
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Registers the header view
        collectionView?.register(UserProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        // Registers the item cells
        collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        // Creates a flow layout for the collectionview
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    //MARK: COLLECTION VIEW PROTOCOLS
    
    // Header for the profile
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)

        return header
    }
    
    // Collection View of items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePhotoCell
        
        cell.post = posts[indexPath.item]
        
        return cell
    }
}

extension UserProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 6) / 3
        return CGSize(width: width, height: width)
    }
    
    // Size of the header for the profile
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}
