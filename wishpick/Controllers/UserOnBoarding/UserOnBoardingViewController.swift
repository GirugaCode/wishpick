//
//  UserOnBoardingViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 4/28/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserOnBoardingViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: PROPERTIES
    /// Stores all the pages for user onboarding
    let onboardPages = [
        UserOnBoarding(imageName: #imageLiteral(resourceName: "user-setup-1"), headerText: "Welcome", bodyText: "wishpick wants to provide a real way for people to connect and know which items they want to make that next occasion special!"),
        UserOnBoarding(imageName: #imageLiteral(resourceName: "add-profile-pic"), headerText: "How to Use", bodyText: "wishpick is a platform for you to share all the possible items you wish you had but rather have someone gift you."),
        UserOnBoarding(imageName: #imageLiteral(resourceName: "sample-profile-image"), headerText: "Time create a wishpick list!", bodyText: "Start by uploading yur first picture of what you want and start sharing with your friends and family!")
    ]
    
    // MARK: UI COMPONENTS
    lazy var bottomControlStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// Previous Button for on boarding
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 21)
        button.setTitleColor(#colorLiteral(red: 0.2117647059, green: 0.1529411765, blue: 0.1725490196, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    /// Next Button for on boarding
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: Fonts.proximaRegular, size: 21)
        button.setTitleColor(#colorLiteral(red: 0.2117647059, green: 0.1529411765, blue: 0.1725490196, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    /// Page Controller to show the current page the user is on
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = onboardPages.count
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        setupCollectionView()
    }
    
    // MARK: COLLECTION VIEW LAYOUT
    /// Constraints for the bottom controls for on boarding
    fileprivate func setupBottomControls() {
        
        view.addSubview(bottomControlStackView)
        
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    fileprivate func setupCollectionView() {
        self.navigationController?.navigationBar.isHidden = true
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.register(UserOnBoardingCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    // MARK: HANDLE FUNCS
    /// Handles the next button for user onboarding to advance to the next step
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, onboardPages.count - 1)
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        doneWithOnboarding()
    }
    
    /// Handles the previous button for user onboarding to go to the previous step
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    /// Handles the done button to complete the on boarding
    @objc private func handleDone(_ sender: UIButton) {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    /// Scrolling animation go drag through on boarding
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageIndicator = targetContentOffset.pointee.x
        pageControl.currentPage = Int(pageIndicator / view.frame.width)
        doneWithOnboarding()
    }
    
    /// Transition the on boarding controller to the next page and change the pageControl indexPath
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in }
    }
    
    /// Shows the Done button once user is done with on boarding
    private func doneWithOnboarding () {
        if pageControl.currentPage == 2 {
            nextButton.setTitle("Done", for: .normal)
            nextButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        }
    }
}


extension UserOnBoardingViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        
        return onboardPages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserOnBoardingCell
        
        let page = onboardPages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
