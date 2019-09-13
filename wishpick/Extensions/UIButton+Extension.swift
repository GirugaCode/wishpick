//
//  UIButton+Extension.swift
//  wishpick
//
//  Created by Ryan Nguyen on 9/12/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

extension UIButton {
    func roundedButton(button:UIButton) {
        button.layer.cornerRadius = button.frame.height/2
    }
}
