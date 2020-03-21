//
//  Comment.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/20/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct Comment {
    let text: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
