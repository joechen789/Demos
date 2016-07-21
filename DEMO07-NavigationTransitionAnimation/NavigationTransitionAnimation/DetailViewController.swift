//
//  DetailViewController.swift
//  NavigationTransitionAnimation
//
//  Created by Broccoli on 16/7/19.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orangeColor()
        navigationController?.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

extension DetailViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Pop {
            self.navigationController?.navigationBarHidden = true
            return YRDynamicPasswordTransition()
        } else {
            return nil
        }
    }
}
