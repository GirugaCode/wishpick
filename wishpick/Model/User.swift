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
    let blockedUsers: String
    let blockedBy: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.blockedUsers = dictionary["blockedUsers"] as? String ?? ""
        self.blockedBy = dictionary["blockedBy"] as? String ?? ""
    }
}
