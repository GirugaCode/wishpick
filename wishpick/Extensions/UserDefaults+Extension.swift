//
//  UserDefaults+Extension.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/24/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Foundation

extension UserDefaults {
    /**
     Sets the logged in status for a user

     - Parameters:
        - value: Bool to identify if the user is logged in or logged out
     */
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    /**
     Bool to check is the user is logged in

     - Returns: true or false if the user is logged in
     */
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
}
