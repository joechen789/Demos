//
//  ViewController.swift
//  NaviDemo
//
//  Created by Broccoli on 16/7/13.
//  Copyright © 2016年 youzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: #selector(foo1), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        let longPressGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(foo))
        longPressGestureRecognizer.numberOfTouchesRequired = 1
        longPressGestureRecognizer.numberOfTapsRequired = 3
        button.addGestureRecognizer(longPressGestureRecognizer)
    }
    func foo1()  {
        
    }
    func foo() {
        
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondViewController")
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

