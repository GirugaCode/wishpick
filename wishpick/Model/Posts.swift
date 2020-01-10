//
//  Posts.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct Posts {
    let user: User
    let imageUrl: String
    let itemInfo: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.itemInfo = dictionary["itemInfo"] as? String ?? "" 
    }
}
