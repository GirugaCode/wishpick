//
//  UserOnBoardingViewModel.swift
//  wishpick
//
//  Created by Ryan Nguyen on 5/13/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import Foundation

class UserOnBoardingCollectionViewModel {
    private var items: [UserOnBoarding]!
    
    private var cellViewModels: [UserOnBoardingCellViewModel] = [UserOnBoardingCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var reloadCollectionViewClosure: (()->())?

    func createCellViewModel(page: UserOnBoarding) -> UserOnBoardingCellViewModel {
        return UserOnBoardingCellViewModel(imageName: page.image, headerText: page.header, bodyText: page.body)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> UserOnBoardingCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createOnBoarding () {
        let onboardPages = [
            UserOnBoarding(image: #imageLiteral(resourceName: "user-setup-1"), header: "Welcome", body: "wishpick wants to provide a real way for people to connect and know which items they want to make that next occasion special!"),
            UserOnBoarding(image: #imageLiteral(resourceName: "add-profile-pic"), header: "How to Use", body: "wishpick is a platform for you to share all the possible items you wish you had but rather have someone gift you."),
            UserOnBoarding(image: #imageLiteral(resourceName: "sample-profile-image"), header: "Time create a wishpick list!", body: "Start by uploading yur first picture of what you want and start sharing with your friends and family!")
        ]
        
        var viewModelSource = [UserOnBoardingCellViewModel]()
        for page in onboardPages {
            viewModelSource.append(createCellViewModel(page: page))
        }
        self.cellViewModels = viewModelSource
    }
}
