//
//  UserSetupViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 10/17/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class UserSetupViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    //MARK: PROPERTIES
    var pages = [UIViewController]()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.frame = CGRect()
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3450980392, alpha: 1)
        pc.pageIndicatorTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    //MARK: OVERRIDE FUNCTIONS
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        // Hide the navigation bar on the this view controller
    //        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //
    //        // Show the navigation bar on other view controllers
    //        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupPageControl()
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    private func setupPageControl() {
        self.dataSource = self
        self.delegate = self
        
        let initialPage = 0
        let page1 = UserSetupPg1VC()
        let page2 = UserSetupPg2VC()
        let page3 = UserSetupPg3VC()
        
        // add the individual viewControllers to the pageViewController
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        setViewControllers([pages[initialPage]], direction: .forward, animated: false, completion: nil)
        
        view.addSubview(pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    //MARK: PROTOCOLS
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)
        let previousIndex = abs((currentIndex! - 1) % pages.count)

        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)
        let previousIndex = abs((currentIndex! + 1) % pages.count)

        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}