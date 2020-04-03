//
//  UIViewController+Extension.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/31/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Custom function to dismiss keyboard by tapping out of it
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
