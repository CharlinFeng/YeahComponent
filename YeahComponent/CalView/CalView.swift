//
//  CalView.swift
//  YeahComponent
//
//  Created by 冯成林 on 15/12/15.
//  Copyright © 2015年 冯成林. All rights reserved.
//

import UIKit

class CalView: UIView {
    
    enum MathType {
        
        /** 整型 */
        case Int_Type
        
        /** 整型 */
        case Float_Type
    }
    
    
    @IBOutlet weak var calTF: UITextField!
    
    @IBOutlet weak var reduceBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    
    var mathType: MathType!
    var editable: Bool = true{didSet{editableKVO()}}
    var calValue_Defalut: String = "0"{didSet{calValue_DefalutKVO()}}
    var step: String = "1"
    var calValue_Min:String = "0"
    var calValue_Max: String = "0"
    
    var calValue_Final: String {
        
        get{return calTF.text ?? ""}
        set{calTF.text = "\(newValue)"}
    }
    
    var timer: NSTimer!
    var isAdd: Bool!
    var valueChangeClosure:(Void->Void)?
    deinit{NSNotificationCenter.defaultCenter().removeObserver(self)}
}


extension CalView {
    
    /** 获取实例 */
    class func calViewInstance(mathType: MathType, defaultValue: String, step: String, min: String, max: String, editable: Bool)->CalView {
        
        let calView = NSBundle.mainBundle().loadNibNamed("CalView", owner: nil, options: nil).first as! CalView
        calView.mathType = mathType
        calView.calValue_Defalut = defaultValue
        calView.step = step
        calView.calValue_Min = min
        calView.calValue_Max = max
        calView.editable = editable
        
        return calView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        radius(4)
        border(width: 1, color: hexColor("f15a5a"))
        calTF.border(width: 1, color: hexColor("f15a5a"))
        calValue_Final = calValue_Defalut
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tfTextDidChange:", name: UITextFieldTextDidChangeNotification, object: calTF)
        
        calViewPrepare()
    }
    
    func editableKVO(){
        calTF.enabled = editable
    }
    
    
    func calValue_DefalutKVO(){
        calTF.text = "\(calValue_Defalut)"
        valueChangeClosure?()
    }
    
    
    
    
    func tfTextDidChange(noti: NSNotification){
        
        if calValue_Final != "0" {calValue_Final = calTF.text ?? "0"}
        check()
    }
    
    @IBAction func reduceAction(sender: AnyObject!) {
        calTF.resignFirstResponder()
        
        if mathType == MathType.Int_Type { //Int
            
            if calValue_Final.toInt_CalView > calValue_Min.toInt_CalView {
                calValue_Final = "\(calValue_Final.toInt_CalView - step.toInt_CalView)"
            }else {
                calValue_Final = calValue_Min
            }
            
        }else{
            
            if calValue_Final.toFloat_CalView > calValue_Min.toFloat_CalView {
                calValue_Final = "\(calValue_Final.toFloat_CalView - step.toFloat_CalView)"
            }else {
                calValue_Final = calValue_Min
            }
        }
        
        check()
    }
    @IBAction func addAction(sender: AnyObject!) {
        
        calTF.resignFirstResponder()
        
        if mathType == MathType.Int_Type { //Int
            
            if calValue_Final.toInt_CalView < calValue_Max.toInt_CalView {
                calValue_Final = "\(calValue_Final.toInt_CalView + step.toInt_CalView)"
            }else {
                calValue_Final = calValue_Max
            }
            
        }else{
            
            if calValue_Final.toFloat_CalView < calValue_Max.toFloat_CalView {
                calValue_Final = "\(calValue_Final.toFloat_CalView + step.toFloat_CalView)"
            }else {
                calValue_Final = calValue_Max
            }
        }
        
        check()
    }
    
    
    func check(){
        
        if mathType == MathType.Int_Type { //Int
            
            if calValue_Final.toInt_CalView <= calValue_Min.toInt_CalView {calValue_Final = calValue_Min;touc_up()}
            if calValue_Final.toInt_CalView >= calValue_Max.toInt_CalView {calValue_Final = calValue_Max;touc_up()}
            
            let text = calTF.text
            
            if text!.hasPrefix("0") && text!.length > 1{
                
                calTF.text = (text as! NSString).stringByReplacingOccurrencesOfString("0", withString: "")
            }
            
        }else {
            
            if calValue_Final.toFloat_CalView <= calValue_Min.toFloat_CalView {calValue_Final = calValue_Min;touc_up()}
            if calValue_Final.toFloat_CalView >= calValue_Max.toFloat_CalView {calValue_Final = calValue_Max;touc_up()}
        }
        
        
        valueChangeClosure?()
    }
}


extension String {
    
    var toFloat_CalView: Float {
        return (self as NSString).floatValue
    }
    
    var toInt_CalView: Int {
        return (self as NSString).integerValue
    }
}


