//
//  SpacerView+Extension.swift
//  wishpick
//
//  Created by Ryan Nguyen on 9/3/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class SpacerView: UIView {
    fileprivate let space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }
    
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
