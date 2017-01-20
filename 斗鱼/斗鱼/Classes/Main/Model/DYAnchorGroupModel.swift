//
//  DYAnchorGroupModel.swift
//  斗鱼
//
//  Created by pba on 2017/1/19.
//  Copyright © 2017年 wenjun. All rights reserved.
//  固定的模型

import UIKit

class DYAnchorGroupModel: NSObject {
    //房间列表
    var room_list : [[String : NSObject]]? {
        //属性监听器
        didSet {
            //1.效验是否有值
            guard let roomArray = room_list else {return}
            //2.字典转模型
            for dict in roomArray {
                
                anchors.append(DYAnchorModel(dict: dict))
            }
        }
    }
    //头像
    var icon_name : String = "home_header_normal"
    //分类名
    var tag_name : String = ""
    //子模型
    var anchors : [DYAnchorModel] = [DYAnchorModel]()
    
    //构造函数
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
