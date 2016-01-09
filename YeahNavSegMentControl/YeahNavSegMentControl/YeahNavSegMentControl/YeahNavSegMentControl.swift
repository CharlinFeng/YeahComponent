//
//  YeahNaSegMentControl.swift
//  YeahNavSegMentControl
//
//  Created by 冯成林 on 16/1/9.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit




class YeahNavBtn: UIButton {
    
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    override var highlighted: Bool {get {return super.highlighted} set{}}
    
    func viewprepare(){
        
        setTitleColor(UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1), forState: UIControlState.Normal)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
        
    }
}



class YeahNavSegMentControl: CFSegmentControl {
    
    var moreWidth: CGFloat = 0
    var itemMoreHeight: CGFloat = -6
    lazy var bgView: UIView = UIView()
    
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    lazy var itemBgView: UIView = UIView()
    
    override var selectedIndex: Int{
    
        set{super.selectedIndex = newValue; selectedIndexKVO()}
        get{return super.selectedIndex}
    }
    
    
}



extension YeahNavSegMentControl{

    func viewprepare(){
        
        addSubview(bgView)
        bgView.backgroundColor = UIColor.blackColor()
    
        addSubview(itemBgView)
        itemBgView.backgroundColor = UIColor(red: 123.0/255.0, green: 1, blue: 1, alpha: 1)
    }
    
    override func btnAdd() {
        
        super.btnAdd()
     
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.selectedIndexKVO()
        })
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let more: CGFloat = moreWidth
        var frame = bounds
        frame.size.width += more
        frame.origin.x = -(moreWidth * 0.5)
        bgView.frame = frame
        
        if(bgView.layer.cornerRadius == 0) {bgView.layer.cornerRadius = bounds.size.height * 0.5}
        if(itemBgView.layer.cornerRadius == 0) {itemBgView.layer.cornerRadius = (bounds.size.height + itemMoreHeight) * 0.5}
        selectedIndexKVO()
    }

    func selectedIndexKVO(){
       
        var btnFrame = self.btns[self.selectedIndex].frame
        if CGRectEqualToRect(btnFrame, CGRectZero) {return}
        btnFrame.size.height += itemMoreHeight
        btnFrame.origin.y = -itemMoreHeight * 0.5
        
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.itemBgView.frame = btnFrame
        }, completion: nil)
    }

}