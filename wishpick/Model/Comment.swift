//
//  Comment.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/20/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct Comment {
    let user: User
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
