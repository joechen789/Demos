
//
//  AnimatedContentsDisplayLayer.swift
//  Layers
//
//  Created by Broccoli on 16/6/24.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit

class AnimatedContentsDisplayLayer: _ASDisplayLayer {
    override func actionForKey(event: String) -> CAAction? {
        if let action = super.actionForKey(event) {
            return action
        }
        
        if event == "contents" && contents == nil {
            let transition = CATransition()
            transition.duration = 0.6
            transition.type = kCATransitionFade
            return transition
        }
        
        return nil
    }
}
