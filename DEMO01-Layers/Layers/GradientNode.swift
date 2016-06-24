//
//  GradientNode.swift
//  Layers
//
//  Created by Broccoli on 16/6/23.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit

class GradientNode: ASDisplayNode {
    class func drawRect(bounds: CGRect, withParameters parameters: NSObjectProtocol!, isCancelled isCancelledBlock: asdisplaynode_iscancelled_block_t!, isRasterizing: Bool) {
        let myContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(myContext)
        CGContextClipToRect(myContext, bounds)
        
        let componentCount: UInt = 2
        let locations: [CGFloat] = [0.0, 1.0]
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0,
                                     0.0, 0.0, 0.0, 0.0]
        let myColorSpace = CGColorSpaceCreateDeviceRGB()
        let myGradient = CGGradientCreateWithColorComponents(myColorSpace, components,
                                                             locations, Int(componentCount))
        
        let myStartPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
        let myEndPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        CGContextDrawLinearGradient(myContext, myGradient, myStartPoint,
                                    myEndPoint, .DrawsAfterEndLocation)
        
        CGContextRestoreGState(myContext)
    }
}
