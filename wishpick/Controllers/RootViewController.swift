//
//  RootViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 8/17/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private var current: UIViewController
    
    init() {
        self.current = LoginViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: LOAD VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current) // Adds the VC to the root
        current.view.frame = view.bounds // Adjust its frames
        view.addSubview(current.view) // Add new subview
        current.didMove(toParent: self) // Finishing adding the child view controller
    }
    
    //MARK: View Controller Stack Functions
    func showLoginScreen() {
        let new = UINavigationController(rootViewController: LoginViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil) // Prepares the current view to be removed
        current.view.removeFromSuperview() // Remove the current view from superview
        current.removeFromParent() // Remove the current view from the RootViewController
        
        current = new // Update the current view controller
    }
    
    func switchToSignUpWithEmail() {
        let emailViewController = EmailViewController()
        let emailScreen = UINavigationController(rootViewController: emailViewController)
        animateFadeTransition(to: emailScreen)
    }
    
    func switchToSignInWithEmail() {
        let emailLoginController = EmailLoginController()
        let emailLoginScreen = UINavigationController(rootViewController: emailLoginController)
        animateFadeTransition(to: emailLoginScreen)
    }
    
    func switchToMainScreen() {
        let mainViewController = MainTabViewController()
        let mainScreen = UINavigationController(rootViewController: mainViewController)
        animateFadeTransition(to: mainScreen)
    }
    
    func switchToLogin() {
        let loginViewController = LoginViewController()
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
    func switchToUserOnBoarding() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let userSetupViewController = UserOnBoardingViewController(collectionViewLayout: layout)
        let userSetupScreen = UINavigationController(rootViewController: userSetupViewController)
        animateDismissTransition(to: userSetupScreen)
    }
    
    //MARK: Transition Animations
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    

}
