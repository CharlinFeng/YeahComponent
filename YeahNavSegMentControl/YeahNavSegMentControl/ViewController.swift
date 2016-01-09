//
//  ViewController.swift
//  YeahNavSegMentControl
//
//  Created by 冯成林 on 16/1/9.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sc = YeahNavSegMentControl()
        sc.moreWidth = 8
        sc.frame = CGRectMake(0, 0, 200, 36)
        
        let btn1 = YeahNavBtn()
        btn1.setTitle("已下单", forState: UIControlState.Normal)
        
        let btn2 = YeahNavBtn()
        btn2.setTitle("已完成", forState: UIControlState.Normal)
        
        let btn3 = YeahNavBtn()
        btn3.setTitle("已退款", forState: UIControlState.Normal)
        
        sc.btns = [btn1, btn2, btn3]
        
        navigationItem.titleView = sc
        
    }


}

