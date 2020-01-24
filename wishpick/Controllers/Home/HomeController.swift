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
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationForFeed()
        refreshController()
        setupCollectionView()
        setupNavigationItems()
        fetchAllPosts()
    }
    
    /**
     Sets up the refresh controller to reload posts
     */
    private func refreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchAllPosts()
    }
    
    /**
     Observes when the user post a photo to refresh the home view
     */
    private func notificationForFeed() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotification, object: nil)
    }
    
    @objc func handleUpdateFeed() {
        handleRefresh()
    }
    
    /**
     Sets up navigation properties for the view controller
     */
    private func setupNavigationItems() {
        //TODO: Make a custom Image View to change the size
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "wishpick-banner"))
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9960784314, green: 0.7254901961, blue: 0.3411764706, alpha: 1)
    }
    
    /**
     Sets up collection view of the cell
     */
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func fetchAllPosts() {
        fetchPosts()
        fetchFollowingUserIds()
    }
    
    /**
     Fetches the post of the current user
     */
    fileprivate func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return } // Current User
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
    }
    
    /**
     Fetches the ids of all the users the CURRENT user are following
     */
    fileprivate func fetchFollowingUserIds() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
            
            userIdsDictionary.forEach({ (key, value) in
                Database.fetchUserWithUID(uid: key) { (user) in
                    self.fetchPostsWithUser(user: user)
                }
            })
            
        }) { (err) in
            print("Failed to fetch following user ids:", err)
        }
    }
    
    /**
     Fetches the post with a given user id
     
     - Parameters:
     - user: The user id of a user
     */
    fileprivate func fetchPostsWithUser(user: User) {
        
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.collectionView.refreshControl?.endRefreshing()
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            // Iterates through the Dictionary of posts and appends it to the post array
            dictionaries.forEach { (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let post = Posts(user: user, dictionary: dictionary)
                self.posts.append(post)
            }
            
            self.posts.sort { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            } // Sorts the posts in decending order based on creation date
            
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
        var height: CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
}
