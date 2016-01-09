//
//  YeahMeauBarView.swift
//  YeahMeauBarView
//
//  Created by 冯成林 on 16/1/9.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit


class YeahMeauBarBtn: UIButton {
    
    lazy var yellowColor: UIColor = UIColor(red: 248.0/255.0, green: 231.0/255.0, blue: 28.0/255.0, alpha: 1)
    
    override var highlighted: Bool {get {return super.highlighted} set{}}
    
    convenience init(title: String!, img_normal: UIImage!, img_selected: UIImage!){
    
        self.init(frame: CGRectZero)
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        setImage(img_normal, forState: UIControlState.Normal)
        setImage(img_selected, forState: UIControlState.Normal)
        setTitleColor(yellowColor, forState: UIControlState.Selected)
        setTitle(title, forState: UIControlState.Normal)
    }
    
}


class YeahMeauBarDotView: UIView {
    
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    func viewprepare(){
        backgroundColor = UIColor(patternImage: UIImage(named: "YeahMeauBarView.bundle/dotline")!)
    }
}



class YeahMeauBarView: CFSegmentControl {

    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    lazy var bgView: UIView! = {
    
        var v: UIView! = nil
        
        
        if #available(iOS 8.0, *) {
            v = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        } else {
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.Black
            v = toolBar
        }
    
        return v
    }()
    
    private lazy var topLineView: YeahMeauBarDotView = YeahMeauBarDotView()
    private lazy var bottomLineView: YeahMeauBarDotView = YeahMeauBarDotView()
}

extension YeahMeauBarView {

    
    func viewprepare(){
        
        addSubview(bgView)
        addSubview(topLineView)
        addSubview(bottomLineView)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let size = bounds.size
        
        topLineView.frame = CGRectMake(0, 0, size.width, 1)
        bottomLineView.frame = CGRectMake(0, size.height - 1, size.width, 1)
        bgView.frame = bounds
    }

}
