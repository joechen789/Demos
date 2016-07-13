//
//  SecondViewController.swift
//  NaviDemo
//
//  Created by Broccoli on 16/7/13.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orangeColor()
        navigationController?.delegate = self
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: #selector(foo), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func foo() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThirdViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension SecondViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if let _ = viewController as? SecondViewController {
            navigationController.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController.setNavigationBarHidden(false, animated: true)
        }
    }
}
