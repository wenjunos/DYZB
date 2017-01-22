//
//  DYRecommendCycleModel.swift
//  斗鱼
//
//  Created by pba on 2017/1/22.
//  Copyright © 2017年 wenjun. All rights reserved.
//  banner模型

import UIKit

class DYRecommendCycleModel: NSObject {
    //标题
    var title : String = ""
    //图片url
    var pic_url : String = ""
    //房间数据
    var room : [String : NSObject]? {
        didSet {
            //字典转模型
            guard let room = room else { return }
            anchor = DYAnchorModel(dict: room)
        }
    }
    //房间数据转为模型
    var anchor : DYAnchorModel?
    
    // MARK: - 自定义构造方法
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
