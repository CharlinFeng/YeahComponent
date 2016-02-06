//
//  CalView+LongPressGesture.swift
//  YeahComponent
//
//  Created by 冯成林 on 16/2/6.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit

extension CalView {

    func calViewPrepare(){
    
        reduceBtn.addTarget(self, action: "reduce_touch_down", forControlEvents: UIControlEvents.TouchDown)
        reduceBtn.addTarget(self, action: "touc_up", forControlEvents: UIControlEvents.TouchUpInside)
        
        addBtn.addTarget(self, action: "add_touch_down", forControlEvents: UIControlEvents.TouchDown)
        addBtn.addTarget(self, action: "touc_up", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func reduce_touch_down(){
        isAdd = false
        long_common()
    }
    
    func add_touch_down(){
        isAdd = true
        long_common()
    }
    
    func touc_up(){
    
        timer?.invalidate()
        timer = nil
    }
    
    func long_common(){
    
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        
    }
    
    func timerAction(){
    
        if isAdd! {
        
            addAction(nil)
            
        }else {
        
            reduceAction(nil)
        }
    }
    



}
