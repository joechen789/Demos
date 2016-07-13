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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

