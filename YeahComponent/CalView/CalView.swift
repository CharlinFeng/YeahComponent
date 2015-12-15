//
//  CalView.swift
//  YeahComponent
//
//  Created by 冯成林 on 15/12/15.
//  Copyright © 2015年 冯成林. All rights reserved.
//

import UIKit

class CalView: UIView {
    
    @IBOutlet weak var calTF: UITextField!

    var calValue_Defalut: Int = 1
    var step: Int = 2
    var calValue_Min = 0
    var calValue_Max = 12

    var calValue_Final: Int {
        
        get{return Int(calTF.text!) ?? 0}
        set{calTF.text = "\(newValue)"}
    }
}

extension CalView {
    
    /** 获取实例 */
    class func calViewInstance()->CalView {
        
        let calView = NSBundle.mainBundle().loadNibNamed("CalView", owner: nil, options: nil).first as! CalView
        
        return calView
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        radius(4)
        border(width: 1, color: hexColor("7bffff"))
        calTF.border(width: 1, color: hexColor("7bffff"))
        calValue_Final = calValue_Defalut
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tfTextDidChange:", name: UITextFieldTextDidChangeNotification, object: calTF)
    }
    
    func tfTextDidChange(noti: NSNotification){
        check()
        if calValue_Final != 0 {calValue_Final = Int(calTF.text!) ?? 0}
    }
    
    func check(){
        if calValue_Final == 0 {calValue_Final=0}
        if calValue_Final > calValue_Max {calValue_Final = calValue_Max}
    }
    
    
    @IBAction func reduceAction(sender: AnyObject) {
        calTF.resignFirstResponder()
        if calValue_Final > 0 {calValue_Final -= step}
        check()
    }
    @IBAction func addAction(sender: AnyObject) {
        if calValue_Final < calValue_Max {calValue_Final += step}
        check()
    }
    
}
