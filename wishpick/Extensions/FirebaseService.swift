//
//  FirebaseService.swift
//  wishpick
//
//  Created by Ryan Nguyen on 4/2/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import Foundation
fileprivate let databaseReference = Database.database().reference()
class FirebaseService {
    static let shared = FirebaseService()
    
    // Reference to firebase database
    
    fileprivate let userReference = databaseReference.child("users")
    fileprivate let followingReference = databaseReference.child("following")
    fileprivate let postReference = databaseReference.child("posts")
    fileprivate let likeReference = databaseReference.child("likes")
    fileprivate let commentReference = databaseReference.child("comments")
    
    //MARK: USER FUNCTIONS
    func add(user: [String: Any?]) {
        
    }
    
    func update(userWithID: String, updatedValue: [String: Any]) {
        
    }
    // func to fetch all post
    // func to authenticate
    // func to like posts
    // func to upload photo
    // func to post comments
    // func to follow/unfollow user
}
