//
//  ViewController.swift
//  NavigationTransitionAnimation
//
//  Created by Broccoli on 16/7/19.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        navigationController?.pushViewController(DetailViewController(), animated: true)
        
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Push {
            self.navigationController?.navigationBarHidden = true
            return YRDynamicPasswordTransition()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
    }
}

