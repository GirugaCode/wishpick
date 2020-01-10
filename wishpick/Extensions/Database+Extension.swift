//
//  Database+Extension.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/10/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Firebase
import Foundation

extension Database {
    /**
     Extension for firebase database to grant access to the current user

     - Parameters:
        - uid: Firebase user ID of the current user

     - Returns: The current user
     */
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: userDictionary)
            
            completion(user)
        }
    }
}
