//
//  ViewController.swift
//  YeahComponent
//
//  Created by 冯成林 on 15/12/15.
//  Copyright © 2015年 冯成林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calViewPrepre()
    }
    
    func calViewPrepre(){
        
        let calView = CalView.calViewInstance()
        calView.frame = CGRectMake(0, 0, 120, 40)
        view.addSubview(calView)
    }


}

