//
//  CustomAnimationDismisser.swift
//  wishpick
//
//  Created by Ryan Nguyen on 3/18/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit
/**
 Custom Animation to dismiss the screen from the CameraController
 */
class CustomAnimationDismisser: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Custom Transition animation logic
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        containerView.addSubview(toView)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            // animation
            fromView.frame = CGRect(x: -fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.width)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}

