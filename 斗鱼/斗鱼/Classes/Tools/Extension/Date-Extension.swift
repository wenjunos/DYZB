//
//  NSDate-Extension.swift
//  斗鱼
//
//  Created by pba on 2017/1/19.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import Foundation

extension Date {
    //获取当前的时间
    static func getCurrentTime() -> String {
        let date = Date()
        
        let time = Int(date.timeIntervalSince1970)
        
        return "\(time)"
    }
}
