//
//  LoginTransition.swift
//  LoginAnimation
//
//  Created by Broccoli on 16/6/27.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class LoginTransition: NSObject {
    private var transitionDuration: NSTimeInterval!
    private var startingAlpha: CGFloat!
    private var isPush: Bool!
    
    required init(transitionDuration duration: NSTimeInterval, startingAlpha alpha: CGFloat, isPush: Bool) {
        transitionDuration = duration
        startingAlpha = alpha
        self.isPush = isPush
    }
}

extension LoginTransition: UIViewControllerAnimatedTransitioning {
    @objc func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    @objc func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view
        
        if isPush! {
            toView.alpha = startingAlpha
            fromView.alpha = 1.0
            
            containerView?.addSubview(toView)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
               
                toView.alpha = 1.0
                fromView.alpha = 0.0
                
                }, completion: { (finished) in
                    
                    fromView?.alpha = 1.0
                    transitionContext.completeTransition(true)
                    
            })
        } else {
            fromView.alpha = 1.0
            toView.alpha = 0.0
            
            fromView?.transform = CGAffineTransformMakeScale(1, 1)
            containerView?.addSubview(toView)
            
            UIView.animateWithDuration(0.3, animations: {
                
                fromView.transform = CGAffineTransformMakeScale(3, 3)
                fromView.alpha = 0.0
                toView.alpha = 1.0
                
                }, completion: { (finished) in
                    
                    fromView.alpha = 1.0
                    transitionContext.completeTransition(true)
                    
            })
        }
    }
}
