//
//  ViewController.swift
//  ArmeemesserDemo
//
//  Created by Jianguo Wu on 2018/5/16.
//  Copyright © 2018年 wujianguo. All rights reserved.
//

import UIKit
import Armeemesser

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh(sender:)))
    }

    @objc func refresh(sender: UIBarButtonItem) {
        let now = Date(timeIntervalSinceNow: 0)
        ChromeDevTools.sharedInstance.log.info(text: "\(now)")
    }

}

