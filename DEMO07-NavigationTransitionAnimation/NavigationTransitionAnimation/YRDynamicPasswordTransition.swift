//
//  YRDynamicPasswordTransition.swift
//  NavigationTransitionAnimation
//
//  Created by Broccoli on 16/7/19.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class YRDynamicPasswordTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view
        
        UIView.transitionFromView(fromView, toView: toView, duration: 0.5, options: .TransitionFlipFromLeft) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}
