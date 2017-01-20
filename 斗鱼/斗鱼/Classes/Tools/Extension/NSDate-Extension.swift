//
//  NSDate-Extension.swift
//  斗鱼
//
//  Created by pba on 2017/1/19.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import Foundation

extension NSDate {
    //获取当前的时间
    class func getCurrentTime() -> String {
        let date = NSDate()
        
        let time = Int(date.timeIntervalSince1970)
        
        return "\(time)"
    }
}
