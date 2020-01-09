//
//  HomeController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import UIKit

class HomeController: UICollectionViewController {
    //MARK: PROPERTIES
    var posts = [Posts]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationItems()
        fetchPosts()
    }
    
    private func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "wishpick-banner"))
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9960784314, green: 0.7254901961, blue: 0.3411764706, alpha: 1)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
