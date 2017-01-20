//
//  DYAnchorModel.swift
//  斗鱼
//
//  Created by pba on 2017/1/20.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYAnchorModel: NSObject {
    //昵称
    var nickname : String = ""
    //房间url
    var room_src : String = ""
    //图片
    var avatar_mid : String = ""
    //在线人数
    var online : Int = 0
    //room_name
    var room_name : String = ""
    //显示时间
    var show_time : Int = 0
    //game_name
    var game_name : String = ""
    //cate_id
    var cate_id : Int = 0
    //判断是手机还是电脑直播:0:电脑，1:手机
    var isVertical : Int = 0
    
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
