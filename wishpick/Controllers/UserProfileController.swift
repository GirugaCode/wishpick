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

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
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
        setupUI()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Creates a flow layout for the collectionview
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Registers the header view
        collectionView?.register(UserProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        // Creates a flow layout for the collectionview
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    // Header for the profile
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)

        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    //MARK: COLLECTION VIEW PROTOCOLS
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
    
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
    
    // Grabs the logged in user data
    fileprivate func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
            // Gives me the username value and stop constantly observing the node in DB
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let usernameDict = snapshot.value as? [String:Any] else { return }
            let username = usernameDict["username"] as? String
            
            self.navigationItem.title = username
            
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
    fileprivate func setupUI() {
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        
    }
}
