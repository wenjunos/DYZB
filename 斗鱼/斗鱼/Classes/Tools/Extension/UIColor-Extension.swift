//
//  UIColor-Extension.swift
//  斗鱼
//
//  Created by pba on 2017/1/13.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - 构造方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
