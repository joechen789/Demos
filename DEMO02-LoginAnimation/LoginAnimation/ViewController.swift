//
//  ViewController.swift
//  LoginAnimation
//
//  Created by Broccoli on 16/6/27.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var loginSwitch: UISwitch!
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPresentControllerButton()
        
        usernameTextField.keyboardType = .ASCIICapable
        passwordTextField.secureTextEntry = true
        
        applySkyscannerTheme(usernameTextField)
        applySkyscannerTheme(passwordTextField)
    }

    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        textField.tintColor = overcastBlueColor
        
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    
    func createPresentControllerButton() {
        let loginButton = LoginAnimationButton(frame: CGRect(x: 20, y: CGRectGetHeight(view.bounds) - 120, width: UIScreen.mainScreen().bounds.size.width - 40, height: 40))
        loginButton.backgroundColor = UIColor(red: 1, green: 0, blue: 128 / 255, alpha: 1)
        loginButton.setTitle("登陆", forState: .Normal)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(ViewController.PresentViewController(_:)), forControlEvents: .TouchUpInside)
    }
    
    func PresentViewController(button: LoginAnimationButton) {
        // 网络请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            if self.loginSwitch.on {
                button.succeedAnimation {
                    [weak self] in
                    self?.didPresentControllerButtonTouch()
                }
                
            } else {
                button.setTitle("密码错误", forState: .Normal)
                button.failedAnimation {
                    
                }
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
        presentViewController(navi, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LoginTransition(transitionDuration: 0.4, startingAlpha: 0.5, isPush: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
