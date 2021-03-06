//
//  SlideAnimator.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit

let duration = 0.2
let moveDistance: CGFloat = 70.0

class PresentSlideAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext
            .viewController(forKey: UITransitionContextViewControllerKey.from)?.view else {
            return
        }
        guard let toView = transitionContext
            .viewController(forKey: UITransitionContextViewControllerKey.to)?.view else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, aboveSubview: fromView)

        toView.frame = containerView.frame
        toView.frame.origin = CGPoint(x: containerView.frame.size.width, y: 0)

        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: [.curveEaseIn, .curveEaseOut],
                       animations: { () -> Void in
                           fromView.frame = fromView.frame.offsetBy(dx: -moveDistance, dy: 0)
                           fromView.alpha = 0.7
                           toView.frame = containerView.frame
        }) { _ -> Void in
            fromView.frame = fromView.frame.offsetBy(dx: -moveDistance, dy: 0)
            transitionContext.completeTransition(true)
        }
    }
}

class DismissSlideAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext
            .viewController(forKey: UITransitionContextViewControllerKey.from)?.view else {
            return
        }
        guard let toView = transitionContext
            .viewController(forKey: UITransitionContextViewControllerKey.to)?.view else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, belowSubview: fromView)

        toView.frame = toView.frame.offsetBy(dx: moveDistance, dy: 0)

        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: [.curveEaseIn, .curveEaseOut],
                       animations: { () -> Void in
                           fromView.frame = fromView.frame.offsetBy(dx: containerView.frame.size.width, dy: 0)
                           toView.frame = toView.frame.offsetBy(dx: moveDistance, dy: 0)
                           toView.alpha = 1.0
        }) { _ -> Void in
            transitionContext.completeTransition(true)
        }
    }
}
