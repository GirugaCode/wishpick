//
//  User.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/9/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
