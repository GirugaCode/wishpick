//
//  UserSearchController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/10/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserSearchController: UICollectionViewController {
    //MARK: PROPERTIES
    let cellId = "cellId"
    
    //MARK: UI COMPONENTS
    /// Search bar to find other users
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for someone"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
}

extension UserSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}
