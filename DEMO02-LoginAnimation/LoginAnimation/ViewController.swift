//
//  ViewController.swift
//  LoginAnimation
//
//  Created by Broccoli on 16/6/27.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usernameTextView: RPFloatingPlaceholderTextField!
    @IBOutlet var passwordTextView: RPFloatingPlaceholderTextField!
    
    @IBOutlet var loginSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPresentControllerButton()
    }
    
    func createPresentControllerButton() {
        let log = HyLoglnButton(frame: CGRect(x: 20, y: CGRectGetHeight(view.bounds) - 120, width: UIScreen.mainScreen().bounds.size.width - 40, height: 40))
        log.backgroundColor = UIColor(red: 1, green: 0, blue: 128 / 255, alpha: 1)
        log.setTitle("登陆", forState: .Normal)
        view.addSubview(log)
        log.addTarget(self, action: #selector(ViewController.PresentViewController(_:)), forControlEvents: .TouchUpInside)
    }
    
    func PresentViewController(button: HyLoglnButton) {
        // 网络请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            if self.loginSwitch.on {
                button.ExitAnimationCompletion({ 
                    [weak self] in
                    self?.didPresentControllerButtonTouch()
                })
            } else {
                button.setTitle("密码错误", forState: .Normal)
                button.ErrorRevertAnimationCompletion({ 
                    
                })
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func didPresentControllerButtonTouch() {
        let controller = MainViewController()
        controller.transitioningDelegate = self
        let navi = UINavigationController(rootViewController: controller)
        navi.transitioningDelegate = self
        self.presentViewController(navi, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HyTransitions(transitionDuration: 0.4, startingAlpha: 0.5, isBOOL: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
