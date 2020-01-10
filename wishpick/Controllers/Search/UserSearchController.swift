//
//  UserSearchController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/10/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class UserSearchController: UICollectionViewController, UISearchBarDelegate {
    //MARK: PROPERTIES
    var users = [User]()
    var filteredUsers = [User]()
    let cellId = "cellId"
    
    //MARK: UI COMPONENTS
    /// Search bar to find other users
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for someone"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        fetchUsers()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true // Scroll the collection view 
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: navBar!.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: navBar!.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: navBar!.trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: navBar!.bottomAnchor),
        ])
    }
    
    fileprivate func fetchUsers() {
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            // Iterates through dictionary of users and adds them into array
            dictionaries.forEach { (key, value) in
                guard let userDictionary = value as? [String: Any] else { return }
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
            }
            
            // Sorts the users in ABC order
            self.users.sort { (u1, u2) -> Bool in
                return u1.username.compare(u2.username) == .orderedAscending
            }
            
            self.filteredUsers = self.users // Add users to filtered users
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to search for users:", err )
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserSearchCell
        
        cell.user = filteredUsers[indexPath.item]
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Edge case if search bar is empty and searches all users in filterted users
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = self.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
        
        self.collectionView?.reloadData()
    }
}

extension UserSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}
