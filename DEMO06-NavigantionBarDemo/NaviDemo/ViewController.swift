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
        
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80)
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        baseView.backgroundColor = UIColor.orange
        
//        self.navigationBar.addSubview(baseView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

