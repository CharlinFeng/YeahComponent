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
        calView.step = "3.5"
        calView.calValue_Min = "0.0"
        calView.calValue_Defalut = "10.0"
        calView.calValue_Max = "17.0"
        calView.editable = false
        calView.mathType = CalView.MathType.Float_Type
        calView.frame = CGRectMake(0, 0, 120, 40)
        view.addSubview(calView)
        
    }


}

