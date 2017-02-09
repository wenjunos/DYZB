//
//  DYBaseGameModel.swift
//  斗鱼
//
//  Created by pba on 2017/2/9.
//  Copyright © 2017年 wenjun. All rights reserved.
//

import UIKit

class DYBaseGameModel: NSObject {
    // MARK: - 属性
    //分类名
    var tag_name : String = ""
    //游戏栏的头像
    var icon_url : String = ""
    //是否需要分割线:默认不需要
    var isNeedLine : Bool = false
    
    //构造函数
    override init() {
        
    }
    
    // MARK: - 构造方法
    init(dict : [String : Any]) {
        super.init()
        //KVC
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
