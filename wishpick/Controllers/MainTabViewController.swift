//
//  MainTabViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 6/29/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    //MARK: TAB BAR NAVIGATION
    private func setupViewControllers() {
        self.delegate = self
        
        // Home
        let homeNavController = templateNavController(unselectedImage:#imageLiteral(resourceName: "home-unfilled"), selectedImage: #imageLiteral(resourceName: "home-filled"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout() ))
        
        // Search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search"), selectedImage: #imageLiteral(resourceName: "search"))
        
        // Add wishpick
        let addWishPickNav = templateNavController(unselectedImage: #imageLiteral(resourceName: "Email-Icon"), selectedImage: #imageLiteral(resourceName: "Email-Icon"))

        // Likes
        let likesNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "heart-unfilled"), selectedImage: #imageLiteral(resourceName: "heart-filled"))
        
        // User Profile
        let layout = UICollectionViewLayout()
        
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "user-unfilled")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "user-filled")
        
        tabBar.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        viewControllers = [homeNavController,
                           searchNavController,
                           addWishPickNav,
                           likesNavController,
                           userProfileNavController]
        
        // Modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        // Spacing for the tab bar icons
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 14, left: 0, bottom: -14, right: 0)
        }
    }
    
    //MARK: SELECT UPLOAD ICON
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelctorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            
            present(navController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    //MARK: SUPPORT
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController // TODO: Create view controller
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }

}
