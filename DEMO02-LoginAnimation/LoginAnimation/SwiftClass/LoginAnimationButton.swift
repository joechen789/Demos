//
//  LoginAnimationButton.swift
//  LoginAnimation
//
//  Created by Broccoli on 16/6/28.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class LoginAnimationButton: UIButton {
    
    typealias AnimationCompletion = Void -> Void
    
    var failedBackgroundColor = UIColor.redColor()
    
    private var shrinkDuration: CFTimeInterval = 0.1
    private var expandDuration: CFTimeInterval = 0.3
    private var  shrinkCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    private var  expandCurve = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
    private var spinerLayer: SpinerLayer!
    private var defaultBackgroundColor = UIColor(red: 4/255.0, green: 186/255.0, blue: 215/255.0, alpha: 1)
    private var animationCompletion: AnimationCompletion?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayer()
        setupTargetAction()
    }
    
    func failedAnimation(WithCompletion completion: AnimationCompletion) {
        animationCompletion = completion
        let shrinkAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnimation.fromValue = CGRectGetHeight(bounds)
        shrinkAnimation.toValue = CGRectGetWidth(bounds)
        shrinkAnimation.duration = shrinkDuration
        shrinkAnimation.timingFunction = shrinkCurve
        shrinkAnimation.fillMode = kCAFillModeForwards
        shrinkAnimation.removedOnCompletion = false
        
        defaultBackgroundColor = backgroundColor!
        
        let backgroundColorAniamtion = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColorAniamtion.toValue = failedBackgroundColor.CGColor
        backgroundColorAniamtion.duration = shrinkDuration
        backgroundColorAniamtion.timingFunction = shrinkCurve
        backgroundColorAniamtion.fillMode = kCAFillModeForwards
        backgroundColorAniamtion.removedOnCompletion = false
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        let originPoint = layer.position
        keyframeAnimation.values = [NSValue(CGPoint: CGPoint(x: originPoint.x, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x - 10, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x + 10, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x - 10, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x + 10, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x - 10, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x + 10, y: originPoint.y)),
                                    NSValue(CGPoint: CGPoint(x: originPoint.x, y: originPoint.y))]
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        keyframeAnimation.duration = 0.5
        keyframeAnimation.delegate = self
        layer.position = originPoint
        
        layer.addAnimation(shrinkAnimation, forKey: shrinkAnimation.keyPath)
        layer.addAnimation(backgroundColorAniamtion, forKey: backgroundColorAniamtion.keyPath)
        layer.addAnimation(keyframeAnimation, forKey: keyframeAnimation.keyPath)
        
        spinerLayer.stopAnimation()
        userInteractionEnabled = true
    }
    
    func succeedAnimation(WithCompletion completion: AnimationCompletion) {
        animationCompletion = completion
        
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandAnimation.fromValue = 1.0
        expandAnimation.toValue = 33.0
        expandAnimation.timingFunction = expandCurve
        expandAnimation.duration = expandDuration
        expandAnimation.delegate = self
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        layer.addAnimation(expandAnimation, forKey: expandAnimation.keyPath)
        spinerLayer.stopAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - animation delegate
extension LoginAnimationButton {
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let basicAnimation = anim as? CABasicAnimation where
            basicAnimation.keyPath == "transform.scale" {
            userInteractionEnabled = true
            if animationCompletion != nil {
                animationCompletion!()
            }
//            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(didStopAnimation), userInfo: nil, repeats: true)
        }
    }
}

private extension LoginAnimationButton {
    func setupLayer() {
        spinerLayer = SpinerLayer(frame: frame)
        layer.addSublayer(spinerLayer)
        layer.cornerRadius = CGRectGetHeight(bounds) / 2
        clipsToBounds = true
    }
    
    func setupTargetAction() {
        addTarget(self, action: #selector(scaleToSmall), forControlEvents: [.TouchDown, .TouchDragEnter])
        addTarget(self, action: #selector(scaleAnimation), forControlEvents: .TouchUpInside)
        addTarget(self, action: #selector(scaleToDefault), forControlEvents: .TouchDragExit)
    }
    
    @objc func scaleToSmall() {
        transform = CGAffineTransformMakeScale(1, 1)
        layer.backgroundColor = self.backgroundColor?.CGColor
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .LayoutSubviews, animations: {
            self.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: nil)
    }
    
    @objc func scaleAnimation() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .LayoutSubviews, animations: {
            self.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        beginAniamtion()
    }
    
    @objc func scaleToDefault() {
        UIView.animateWithDuration(0.3,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.4,
                                   options: .LayoutSubviews,
                                   animations: {
                                    self.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    
    @objc func didStopAnimation() {
        layer.removeAllAnimations()
    }
    
    func beginAniamtion() {
//        if CGColorEqualToColor(layer.backgroundColor, failedBackgroundColor.CGColor)  {
            revertBackgroundColor()
//        }
        
        layer.addSublayer(spinerLayer)
        let shrinkAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnimation.fromValue = CGRectGetWidth(bounds)
        shrinkAnimation.toValue = CGRectGetHeight(bounds)
        shrinkAnimation.duration = shrinkDuration
        shrinkAnimation.timingFunction = shrinkCurve
        shrinkAnimation.fillMode = kCAFillModeForwards
        shrinkAnimation.removedOnCompletion = false
        layer.addAnimation(shrinkAnimation, forKey: shrinkAnimation.keyPath)
        spinerLayer.beginAnimation()
        userInteractionEnabled = false
    }
    
    func revertBackgroundColor() {
        let backgroundColorAniamtion = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColorAniamtion.toValue = defaultBackgroundColor.CGColor
        backgroundColorAniamtion.duration = shrinkDuration
        backgroundColorAniamtion.timingFunction = shrinkCurve
        backgroundColorAniamtion.fillMode = kCAFillModeForwards
        backgroundColorAniamtion.removedOnCompletion = false
        layer.addAnimation(backgroundColorAniamtion, forKey: "revertBackgroundColor")
    }
}

class SpinerLayer: CAShapeLayer {
    required init(frame: CGRect) {
        super.init()
        
        let radius = CGRectGetHeight(frame) / 4
        self.frame = CGRect(x: 0, y: 0, width: CGRectGetHeight(frame), height: CGRectGetHeight(frame))
        let center = CGPoint(x: CGRectGetHeight(frame) / 2, y: CGRectGetMidY(bounds))
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
