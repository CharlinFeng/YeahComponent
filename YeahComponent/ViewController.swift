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
        
        let calView = CalView.calViewInstance(CalView.MathType.Float_Type, defaultValue: "10.0", step: "6", min: "0.0", max: "100.0", editable: false)
        calView.frame = CGRectMake(0, 0, 120, 40)
        view.addSubview(calView)
        
    }


}

