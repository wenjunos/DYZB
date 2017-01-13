//
//  UIBarButtonItem-Extension.swift
//  斗鱼
//
//  Created by pba on 2017/1/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
//    class func creatItem(imgName : String, hlImage : String = "", size : CGSize = CGSize.zero) -> UIBarButtonItem{
//        
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imgName), for: .normal)
//        if hlImage != "" {
//            btn.setImage(UIImage(named: hlImage), for: .highlighted)
//        }
//        if size == CGSize.zero {
//            btn.sizeToFit()
//        }else{
//            btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        }
//        return UIBarButtonItem(customView: btn)
//    }
    
    //便利构造函数：
    //1.convenience开头
    //2.在构造函数中必须明确调用一个设计的构造函数(用self进行调用)
    convenience init(imgName : String, hlImage : String = "", size : CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        if hlImage != "" {
            btn.setImage(UIImage(named: hlImage), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView : btn)
    }
    
}
