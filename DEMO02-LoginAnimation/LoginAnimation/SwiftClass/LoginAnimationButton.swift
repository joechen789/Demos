//
//  LoginAnimationButton.swift
//  LoginAnimation
//
//  Created by Broccoli on 16/6/28.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class LoginAnimationButton: UIButton {


}

class SpinerLayer: CAShapeLayer {
    required init(frame: CGRect) {
        super.init()
        
        let radius = CGRectGetHeight(frame) / 4
        self.frame = CGRect(x: 0, y: 0, width: CGRectGetHeight(frame), height: CGRectGetHeight(frame))
        let center = CGPoint(x: CGRectGetHeight(frame) / 2, y: CGRectGetMinY(bounds))
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = CGFloat(M_PI * 2 - M_PI_2)
        let clockwise = true
        
        path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise).CGPath
        fillColor = nil
        strokeColor = UIColor.whiteColor().CGColor
        lineWidth = 1
        
        strokeEnd = 0.4
        hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        hidden = false

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = M_PI * 2
        rotateAnimation.duration = 0.4
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.removedOnCompletion = false
        addAnimation(rotateAnimation, forKey: rotateAnimation.keyPath)
    }
    
    func stopAnimation() {
        hidden = true
        
        removeAllAnimations()
    }
    
}
