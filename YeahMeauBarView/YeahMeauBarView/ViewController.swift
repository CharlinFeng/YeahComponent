//
//  ViewController.swift
//  YeahMeauBarView
//
//  Created by 冯成林 on 16/1/9.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var control: YeahMeauBarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn1 = YeahMeauBarBtn(title: "已下单", img_normal: nil, img_selected:  nil)
        let btn2 = YeahMeauBarBtn(title: "已完成", img_normal: nil, img_selected:  nil)
        let btn3 = YeahMeauBarBtn(title: "已消费", img_normal: nil, img_selected:  nil)
        let btn4 = YeahMeauBarBtn(title: "已取消", img_normal: nil, img_selected:  nil)
        control.btns = [btn1, btn2, btn3, btn4]
        control.frame = CGRectMake(0, 200, 320, 80)
        
        control.clickItemAtIndex = { i in
            print(i)
        }
    }


}

